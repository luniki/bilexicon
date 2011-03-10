/* ------------------------------------------------------------------------
 * add a valency to a lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addValency = function (button) {
  var location = BILEXICON.id_to_path(button.up("*[id]").id);
  document.location = location + "/valencies/new";
};

