import Ember from 'ember';

const {Component, computed, String} = Ember;

export default Component.extend({
    classNameBindings: ['isDraggable:is-draggable:is-not-draggable', ':drag-region'],
    attributeBindings: ['style'],
    style: computed('isDraggable', function() {
        return String.htmlSafe(`width: ${this.get('width')}; height: ${this.get('height')};`);
    }),
    isDraggable: true
});
