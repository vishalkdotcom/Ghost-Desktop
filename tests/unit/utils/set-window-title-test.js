import setWindowTitle from 'ghost-desktop/utils/set-window-title';
import {module, test} from 'qunit';

const he = require('he');

module('Unit | Utility | set window title');

test('it sets the window title', function(assert) {
    const oldRequire = window.requireNode;
    const newTitle = 'bhargav&apos;s cool blog';
    const decodedTitle = he.decode(newTitle);

    window.requireNode = function (module) {
        if (module === 'electron') {
            return {
                remote: {
                    BrowserWindow: {
                        getFocusedWindow() {
                            return {
                                setTitle(title) {
                                    assert.equal(title, decodedTitle);
                                }
                            };
                        }
                    }
                }
            };
        } else {
            oldRequire(...arguments);
        }
    };

    setWindowTitle(newTitle);

    // Reset
    window.requireNode = oldRequire;
});
