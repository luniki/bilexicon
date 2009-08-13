/* ------------------------------------------------------------------------
 * delete a lemma or subentry
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.deleteEntry = function (button) {

  var element = button.up(".subentry, .entry");
  var resource = element.up("*[id]");
  var route = BILEXICON.id_to_path(resource.id);

  if (confirm('Sind Sie sicher?')) {
    var r = new Ajax.Request(route, {
      method: "delete",
      parameters: {authenticity_token: BILEXICON.token},
      onFailure: function (transport) {
        // TODO
        element.shake();
      },
      onSuccess: function (transport) {
        if (element.hasClassName("subentry")) {
          Effect.SelfHealingFade(element, {
            duration: 0.25,
            afterFinish: Element.remove.curry(resource)
          });
        }
        else {
          document.location = "/lemmata";
        }
      }
    });
  }
};
