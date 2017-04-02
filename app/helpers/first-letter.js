import Ember from 'ember';

const {Helper} = Ember;

export function firstLetter(params) {
    return params[0].slice(0, 1);
}

export default Helper.helper(firstLetter);
