/* ------------------------------------------------------------------------
 * add an example to a lemma or subentry
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addExample = function (button) {
  var location = BILEXICON.id_to_path(button.up("*[id]").id);
  document.location = location + "/examples/new";
};

