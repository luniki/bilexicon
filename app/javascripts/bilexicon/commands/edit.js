/* ------------------------------------------------------------------------
 * edit a lemma's subentries
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.edit = function (button) {

  var subentry = button.up(".subentry"),
      resource = subentry.up("*[id]"),
      route = BILEXICON.id_to_path(resource.id),
      type = resource.id.match(/(\w+)-\d+$/)[1];

  // show faded subentry, fade edit form and remove it
  var cancel_edit_form = function (event) {
    var edit = event.element().up(".subentry-edit");
    Effect.SelfHealingFade(edit, {
      afterFinish: Element.remove.curry(edit)
    });
    Effect.SelfHealingAppear(subentry);
    event.stop();
  };

  // submit subentry and remove edit form
  var submit_edit_form = function (event) {
    var edit = event.element().up(".subentry-edit");
    var r = new Ajax.Request(route, {
      method: "put",
      parameters: edit.down("form").serialize(true),

      // replace resource with response and highlight it
      onSuccess: function (transport) {
        var id = resource.id;
        resource.replace(transport.responseText);
        $(id).down(".subentry").highlight();
      },

      // get errors from response and show them on the invalid fields
      onFailure: function (transport) {
        var errors = transport.responseText.evalJSON();
        errors.each(function (error) {
          var element = edit.down("input[name*='[" + error[0]  + "]']");
          if (!element.parentNode.hasClassName("fieldWithErrors")) {
            element.wrap("span", {"class": "fieldWithErrors"}).insert({
              after: new Element("span", {"class": "input-error"})
                      .update(error[1])
            });
          }
          element.parentNode.next(".input-error").update(error[1]);
        });
      }
    });
    event.stop();
  };


  Effect.SelfHealingFade(subentry);

  var r = new Ajax.Request(route + ".json", {
    method: "get",

    onFailure: function (transport) {
      // TODO
      subentry.shake();
    },

    onSuccess: function (transport) {
      subentry.insert({
        after:  edit_templates[type].evaluate(transport.responseJSON)
      });
      var edit = subentry.next();
      edit.down(".cancel").observe("click", cancel_edit_form);
      edit.down(".submit").observe("click", submit_edit_form);
      BILEXICON.init_mirror_input(edit);
      Effect.SelfHealingAppear(edit);
    }
  });
};

