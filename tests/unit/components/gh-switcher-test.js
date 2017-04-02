import Ember from 'ember';
import {test, moduleForComponent} from 'ember-qunit';

const {run} = Ember;

/**
 * Test Preparation
 */
let recordsSearched = false;
let recordSaved = false;
let recordDeleted = false;

const store = {
    findRecord(/* type, id */) {
        recordsSearched = true;
        return new Promise((resolve) => {
            resolve({
                deleteRecord() {
                    recordDeleted = true;
                },
                save() {
                    recordSaved = true;
                    return new Promise((resolve) => resolve());
                }
            });
        });
    }
};

moduleForComponent('gh-switcher', 'Unit | Component | gh switcher', {
    unit: true,
    needs: ['service:preferences', 'service:windowMenu'],
    beforeEach() {
        recordsSearched = false;
        recordSaved = false;
        recordDeleted = false;
    }
});

test('removeBlog removes a blog', function(assert) {
    assert.expect(3);

    const targetObject = {
        blogRemoved() {
            // This assertion will be called when the action is triggered
            assert.ok(recordsSearched);
            assert.ok(recordDeleted);
            assert.ok(recordSaved);
        }
    };
    const component = this.subject({
        targetObject,
        blogRemoved: 'blogRemoved',
        store
    });

    run(() => component.removeBlog('testid'));
});

test('editBlog edits a blog', function(assert) {
    const targetObject = {
        showEditBlog() {
            // This assertion will be called when the action is triggered
            assert.ok(recordsSearched);
        }
    };
    const component = this.subject({
        targetObject,
        showEditBlog: 'showEditBlog',
        store
    });

    run(() => component.editBlog('testid'));
});
