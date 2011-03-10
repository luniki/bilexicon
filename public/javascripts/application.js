/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * the global BILEXICON namespace
 * ------------------------------------------------------------------------ */
var BILEXICON = {};

BILEXICON.closeForms = function (event) {
  if (event) {
    event.stop();
  }
  document.fire("close:forms");
};


/* ------------------------------------------------------------------------
 * dom:loaded events
 * ------------------------------------------------------------------------ */
document.observe("dom:loaded", function () {

  $$(".default-as-hint").each(function (input) {
    input.defaultValueActsAsHint();
  });

  BILEXICON.init_mirror_input();

  BILEXICON.MultiButton.setup();
});
