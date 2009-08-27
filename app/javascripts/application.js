/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

//= require <prototype>
//= require <effects>
//= require <controls>
//= require <dragdrop>
//= require "extensions"


/* ------------------------------------------------------------------------
 * the global BILEXICON namespace
 * ------------------------------------------------------------------------ */
var BILEXICON = {};

//= require "bilexicon/helpers"
//= require "bilexicon/search"
//= require "bilexicon/invitation"
//= require "bilexicon/commands"
//= require "bilexicon/multibutton"

//= require "bilexicon/wordclass"

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

  if ($("popup-search")) {
    $("popup-search").observe("click", BILEXICON.SearchPopup);
  }

  BILEXICON.init_mirror_input();

  BILEXICON.MultiButton.setup();
});
