//= require <prototype>
//= require <effects>
//= require <controls>
//= require <dragdrop>
//= require "extensions"

/*global $,$w,Element */
/*jslint white: true */


/* ------------------------------------------------------------------------
 * the global BILEXICON namespace
 * ------------------------------------------------------------------------ */
var BILEXICON = {};

//= require "bilexicon/helpers"
//= require "bilexicon/search"
//= require "bilexicon/commands"
//= require "bilexicon/multibutton"

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
