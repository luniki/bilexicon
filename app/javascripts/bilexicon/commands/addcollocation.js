/* ------------------------------------------------------------------------
 * add another collocation
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addCollocation = function () {

  var collocations = $$("ol.collocations").first(),
      location = BILEXICON.id_to_path(collocations.id);

  var r = new Ajax.Request(location + "/new", {

    method: "get",

    onFailure: function (transport) {
      // TODO
      element.shake();
    },

    onSuccess: function (transport) {
      collocations.insert(transport.responseText);
      var form = collocations.childElements().last();
      form.down(".submit").observe("click", function (event) {
        event.stop();

        var r = new Ajax.Request(location, {
          method: "post",
          parameters: form.down("form").serialize(true),

          // replace resource with response and highlight it
          onSuccess: function (transport) {
            form.replace(transport.responseText);
            var created = collocations.childElements().last();
            created.highlight();
            var invitation = created.previous(".invitation");
            invitation.down("a.accept").observe("click", function (event) {
              event.stop();
              console.log(event);
            });
            invitation.down("a.cancel").observe("click", function (event) {
              event.stop();
              invitation.remove();
            });
          },

          // get errors from response and show them on the invalid fields
          onFailure: function (transport) {
            var errors = transport.responseText.evalJSON();
            errors.each(function (error) {
              var element = form.down("input[name*='[" + error[0]  + "]']");
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
      });
      form.down(".cancel").observe("click", function (event) {
        event.stop();
        Effect.SelfHealingFade(form, {
          afterFinish: Element.remove.curry(form)
        });
      });
      form.appear({afterSetup: Element.scrollTo.curry(form)});
    }
  });
};

