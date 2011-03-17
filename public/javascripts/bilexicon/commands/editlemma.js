/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * edit the current lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.editLemma = function () {

  var lemma = $$(".lemma").first(),
      entry = lemma.down(".entry"),
      route = BILEXICON.id_to_path(lemma.id);

  // submit entry and dismiss fade edit form and remove it
  var submit_edit_form = function (event) {
    event.stop();
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
        edit.down(".cancel").observe("click", BILEXICON.closeForms);
        edit.down(".submit").observe("click", submit_edit_form);
        edit.show();
      }
    });
  };

  // show faded entry, fade edit form and remove it
  var stop = function (event) {
    var edit = $("lemma-edit"), entry = $$(".entry").first();
    edit.remove();
    Effect.SelfHealingAppear(entry);
    jQuery(document).unbind("closeForms", stop);
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

      BILEXICON.WordClass.show_additional_fields();
      [1, 2].each(function (side) {
        $("lemma_word_class" + side).observe("change", BILEXICON.WordClass.show_additional_fields);
      });

      jQuery(document).bind("closeForms", stop);

      var edit = entry.next();
      edit.down(".cancel").observe("click", BILEXICON.closeForms);
      edit.down(".submit").observe("click", submit_edit_form);
      Effect.SelfHealingAppear(edit);
    }
  });
};
