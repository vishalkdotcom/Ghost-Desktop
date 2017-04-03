import Ember from 'ember';
import Phrases from '../utils/phrases';

const {Component} = Ember;

export default Component.extend({
    classNames: ['basic-auth'],
    label: Phrases.basicAuth
});
