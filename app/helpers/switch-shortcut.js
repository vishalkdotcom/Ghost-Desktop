import Ember from 'ember';

const {Helper} = Ember;

export function switchShortcut(params) {
    const index = (params && params[0]) ? params[0] + 1 : 1;
    const cmdOrCtrl = (process.platform && process.platform === 'darwin') ? '⌘' : 'Ctrl';

    // If bigger than 9, don't return anything
    return (index > 9) ? '' : `${cmdOrCtrl} ${index}`;
}

export default Helper.helper(switchShortcut);
