/* Counter Script
 * Requires Prototype Library
 * By: <stuff@milkfarmproductions.com>
 * http://milkfarmproductions.com
 * This work is licensed under the Creative Commons Attribution-Share Alike 3.0
 * http://creativecommons.org/licenses/by-sa/3.0/us/
 *
 * Requirements:
 * - A 'texter' input field, the field to be counted
 * - A 'counter' input field with class equal to 'countClass' variable, the field to contain the count
 * - Set id of 'counter' to <TEXTER_ID> + '_count'
 * - Set initial value of 'counter' input field to maximum allowable characters (integer) of 'texter'
 *
 * Recommendations:
 * - Set 'counter' input field to disabled
 *
 * Note:
 * - This script can handle multiple 'texter/counter' pairs on the same page
 * - 'truncate' variable controls whether or not 'texter' is truncated if 'max' is exceeded
 */

var countClass = 'text-count';
var truncate = false;

var Counter = Class.create({

    initialize: function(text_id, count_id, truncate) {
        if(!$(text_id)) throw("Attempted to initalize counter with text id: " + text_id + " which was not found.");
        if(!$(count_id)) throw("Attempted to initalize counter with count id: " + count_id + " which was not found.");
        this.texter = $(text_id);
        this.counter = $(count_id);
        this.max = this.counter.value;
        this.truncate = truncate;
        this.updateCounter();
        var keyHandler = this.keyHandler.bindAsEventListener(this);
        this.texter.observe('keyup', keyHandler);
        this.texter.observe('keydown', keyHandler);
    },

    updateCounter: function(el) {
      this.counter.value = this.max - this.texter.value.length;
    },

    truncateTexter: function(el) {
      this.texter.value = this.texter.value.substring(0, this.max);
    },

    keyHandler: function(e) {
      if (this.truncate && this.texter.value.length > this.max) {
        this.truncateTexter();
      } else {
        this.updateCounter();
      }
    }

});

document.observe("dom:loaded", function(){
  count_els = $$('input.' + countClass);
  for (var i = 0; i < count_els.length; i++) {
    var count_id = count_els[i].id;
    var text_id = count_id.replace(/_count$/, '');
    new Counter(text_id, count_id, truncate);
  }
})
