/* ------------------------------------------------------------------------
 * add a phraseologism to a lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addPhraseologism = function (button) {
  var location = BILEXICON.id_to_path(button.up("*[id]").id);
  document.location = location + "/phraseologisms/new";
};

