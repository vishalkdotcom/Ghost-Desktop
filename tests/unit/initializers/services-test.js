import Ember from 'ember';
import ServicesInitializer from 'ghost-desktop/initializers/services';
import {module, test} from 'qunit';

const {run, Application} = Ember;

let application;

module('Unit | Initializer | services', {
    beforeEach() {
        run(function() {
            application = Application.create();
            application.deferReadiness();
        });
    }
});

// Replace this with your real tests.
test('it works', function(assert) {
    ServicesInitializer.initialize(application);

  // you would normally confirm the results of the initializer here
    assert.ok(true);
});
