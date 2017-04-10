import Ember from 'ember';
import {storageFor} from 'ember-local-storage';

const {Service, Evented, computed, $} = Ember;

export default Service.extend(Evented, {
    preferences: storageFor('preferences'),

    isQuickSwitcherMinimized: computed.alias('preferences.isQuickSwitcherMinimized'),
    isNotificationsEnabled: computed.alias('preferences.isNotificationsEnabled'),
    contributors: computed.alias('preferences.contributors'),
    spellcheckLanguage: computed.alias('preferences.spellcheckLanguage'),

    zoomFactor: computed({
        get() {
            return this.get('preferences.zoomFactor');
        },
        set(k, v) {
            const frame = require('electron').webFrame;
            const setting = (v >= 50 && v <= 300) ? v : 100;

            frame.setZoomFactor(setting / 100);
            this.set('preferences.zoomFactor', setting);
        }
    }),

    init() {
        this.setupContributors();
    },

    setupContributors() {
        $.getJSON('../../ember-electron/main/contributors.json').then(
            (data) => this.set('preferences.contributors', data)
        );
    },

    setupZoom() {
        this.set('zoomFactor', this.get('zoomFactor'));
    }
});
