/*global Node,$$,$,$A,$w,Ajax,Effect,Element,Prototype,Template,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * edit a lemma's subentries
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.edit = (function ($) {

    return function (button) {

        var subentry = button.closest(".subentry"),
        resource = subentry.closest("*[id]"),
        resource_id = resource.attr("id"),
        route = BILEXICON.id_to_path(resource_id),
        type = resource_id.match(/(\w+)-\d+$/)[1];

        subentry.fadeOut();

        jQuery.ajax({
            url: route + ".json",
            method: "get"
        }).error(function (jqXHR, textStatus, errorThrown) {
            // TODO
            subentry.effect("shake");
        }).success(function (data) {
            var edit = subentry.after(JST[type + "/edit"](data)).next();

            var stop = function () {
                edit.remove();
                subentry.fadeIn();
                jQuery(document).unbind("closeForms", stop);
            };
            jQuery(document).bind("closeForms", stop);

            edit.find(".cancel").click(BILEXICON.closeForms);
            edit.find(".submit").click(submit_edit_form);
            
            BILEXICON.init_mirror_input(edit);
            edit.fadeIn(function () {
                edit.find("input[type=text]").focus();
            });
        });

        // submit subentry and remove edit form
        function submit_edit_form(event) {
            event.preventDefault();
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
        }
    };
}(jQuery));
