/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * add another collocation
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addCollocation = function () {

  var collocations = $$("ol.collocations").first(),
      location = BILEXICON.id_to_path(collocations.id);

  var retrieveForm = function (transport) {
    collocations.insert(transport.responseText);
    var li = collocations.childElements().last();
    BILEXICON.init_mirror_input(li);

    var createCollocation = function (event) {
      event.stop();

      var r = new Ajax.Request(location, {
        method: "post",
        parameters: li.down("form").serialize(true),

        // replace resource with response and highlight it
        onSuccess: function (transport) {
          li.replace(transport.responseText);
          var created = collocations.childElements().last();
          created.highlight();
          var invitation = new BILEXICON.Invitation(created.previous(".invitation"),
                                                    BILEXICON.Commands.addCollocation);
        },

        // get errors from response and show them on the invalid fields
        onFailure: function (transport) {
          var errors = transport.responseText.evalJSON();
          errors.each(function (error) {
            var element = li.down("input[name*='[" + error[0]  + "]']");
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

    var stop = function () {
      li.remove();
      jQuery(document).unbind("closeForms", stop);
    };
    jQuery(document).bind("closeForms", stop);

    li.down(".submit").observe("click", createCollocation);
    li.down(".cancel").observe("click", BILEXICON.closeForms);

    li.appear({afterSetup: function () {
      li.scrollTo().down("input[type=text]").focus();
    }});
  };


  var r = new Ajax.Request(location + "/new", {
    method: "get",
    // TODO
    onFailure: Element.shake.curry(collocations),
    onSuccess: retrieveForm
  });
};

BILEXICON.Commands.cancelAddCollocation = Prototype.emptyFunction;

