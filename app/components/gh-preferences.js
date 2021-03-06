import Ember from 'ember';

const {Component, inject, computed} = Ember;

export default Component.extend({
    classNames: ['gh-preferences'],
    preferences: inject.service(),
    autoUpdate: inject.service(),
    zoomFactor: computed.oneWay('preferences.preferences.zoomFactor'),

    didReceiveAttrs() {
        this._super(...arguments);
    },

    actions: {
        /**
         * Open a given url in the user's default browser
         *
         * @param url - url to open
         */
        openExternal(url) {
            if (url) {
                requireNode('electron').shell.openExternal(url);
            }
        },

        /**
         * Delete all settings and restart the app
         */
        deleteData() {
            const {remote} = requireNode('electron');
            const {dialog} = remote;

            dialog.showMessageBox({
                type: 'warning',
                buttons: ['Cancel', 'Confirm'],
                title: 'Delete All Settings?',
                defaultId: 0,
                message: 'Do you really want to delete all preferences? This action cannot be undone.'
            }, (response) => {
                if (response === 1) {
                    window.localStorage.clear();
                    window.location.reload();
                }
            });
        },

        /**
         * Install an update, if available
         */
        installUpdate() {
            this.get('autoUpdate').update();
        },

        /**
         * Passes the zoom factor over to the preferences service,
         * where it will immediatly be used as the zoom factor for
         * the app
         */
        confirmZoom() {
            this.set('preferences.zoomFactor', this.get('zoomFactor'));
        },

        /**
         * Resets the zoom factor to 1.0
         */
        resetZoom() {
            this.set('preferences.zoomFactor', 100);
        }
    }
});
