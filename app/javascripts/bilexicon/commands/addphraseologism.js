/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * add a phraseologism to a lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addPhraseologism = function (button) {
  var location = BILEXICON.id_to_path(button.up("*[id]").id);
  document.location = location + "/phraseologisms/new";
};

