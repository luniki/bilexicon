/*global $$,$,$w,Ajax,Effect,Element,Prototype,jQuery */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true, indent: 2 */

/* ------------------------------------------------------------------------
 * the global BILEXICON namespace
 * ------------------------------------------------------------------------ */
var BILEXICON = {};

BILEXICON.closeForms = function (event) {
  if (event) {
    event.preventDefault();
  }
  jQuery(document).trigger("closeForms");
};

BILEXICON.template = function(templateString) {
  return function() { 
    var template = Handlebars.compile(templateString);
    return template(arguments[0]); 
  };
};

/* ------------------------------------------------------------------------
 * dom:loaded events
 * ------------------------------------------------------------------------ */
jQuery(function() {

  BILEXICON.init_mirror_input();

  BILEXICON.MultiButton.setup();
});
