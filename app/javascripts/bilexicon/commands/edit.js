/*global Node,$$,$,$A,$w,Ajax,Effect,Element,Prototype,Template,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * edit a lemma's subentries
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.edit = (function () {

  var edit_templates;

  // initializes the edit templates
  var init_edit_templates = function () {

    if (edit_templates) {
      return;
    }

    edit_templates = {};

    $w("examples valencies collocations phraseologisms").each(function (type) {
      var template = $(type + "-edit-template");
      if (template) {
        var comment = $A($(type + "-edit-template").childNodes).find(function (c) {
            return c.nodeType === Node.COMMENT_NODE;
          });
        if (comment) {
          edit_templates[type] = new Template(comment.nodeValue);
        }
      }
    });
  };

  return function (button) {

    init_edit_templates();

    var subentry = button.up(".subentry"),
        resource = subentry.up("*[id]"),
        route = BILEXICON.id_to_path(resource.id),
        type = resource.id.match(/(\w+)-\d+$/)[1];

    // submit subentry and remove edit form
    var submit_edit_form = function (event) {
      event.stop();
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

        var stop = function () {
          edit.remove();
          Effect.SelfHealingAppear(subentry);
          document.stopObserving("close:forms", stop);
        };
        document.observe("close:forms", stop);

        edit.down(".cancel").observe("click", BILEXICON.closeForms);
        edit.down(".submit").observe("click", submit_edit_form);
        BILEXICON.init_mirror_input(edit);
        Effect.SelfHealingAppear(edit, {afterFinish: function () {
          edit.down("input[type=text]").scrollTo().focus();
        }});
      }
    });
  };
}());

