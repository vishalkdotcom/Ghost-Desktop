import {test, moduleForComponent} from 'ember-qunit';

moduleForComponent('gh-select-native', 'Unit | Component | gh select native', {
    unit: true
});

test('it renders', function(assert) {
    // creates the component instance
    const component = this.subject();

    assert.equal(component._state, 'preRender');

    // renders the component on the page
    this.render();
    assert.equal(component._state, 'inDOM');
});
