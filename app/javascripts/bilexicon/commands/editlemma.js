/* ------------------------------------------------------------------------
 * edit the current lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.editLemma = function () {

  var lemma = $$(".lemma").first(),
      entry = lemma.down(".entry"),
      route = BILEXICON.id_to_path(lemma.id);

  // show faded entry, fade edit form and remove it
  var cancel_edit_form = function (event) {
    var edit = event.element().up(".entry-edit");
    Effect.SelfHealingFade(edit, {
      afterFinish: Element.remove.curry(edit)
    });
    Effect.SelfHealingAppear(entry);
    event.stop();
  };

  // submit entry and dismiss fade edit form and remove it
  var submit_edit_form = function (event) {
    var lemma = event.element().up(".lemma");
    var edit = lemma.down(".entry-edit");
    var r = new Ajax.Request(route, {
      method: "put",
      parameters: edit.down("form").serialize(true),
      onSuccess: function (transport) {
        edit.remove();
        lemma.down(".entry").replace(transport.responseText);
        lemma.down(".entry-line").highlight();
      },
      onFailure: function (transport) {
        edit.replace(transport.responseText);
        edit = lemma.down(".entry-edit");
        edit.down(".cancel").observe("click", cancel_edit_form);
        edit.down(".submit").observe("click", submit_edit_form);
        edit.show();
      }
    });
    event.stop();
  };


  Effect.SelfHealingFade(entry);

  var r = new Ajax.Request(route + "/edit", {
    method: "get",

    onFailure: function (transport) {
      // TODO
      entry.shake();
    },

    onSuccess: function (transport) {
      entry.insert({ after:  transport.responseText });
      var edit = entry.next();
      edit.down(".cancel").observe("click", cancel_edit_form);
      edit.down(".submit").observe("click", submit_edit_form);
      Effect.SelfHealingAppear(edit);
    }
  });
};

