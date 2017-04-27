import Ember from 'ember';

const {String, Helper} = Ember;

export function backgroundStyle([color]) {
    return String.htmlSafe(`background-color: ${color};`);
}

export default Helper.helper(backgroundStyle);
