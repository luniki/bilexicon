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

        $.ajax({
            url: route + ".json",
            type: "get"
        }).error(function (jqXHR, textStatus, errorThrown) {
            // TODO
            subentry.effect("shake");
        }).success(function (data) {
            var edit = subentry.after(JST[type + "/edit"](data)).next();

            var stop = function () {
                edit.remove();
                subentry.fadeIn();
                $(document).unbind("closeForms", stop);
            };
            $(document).bind("closeForms", stop);

            edit.find(".cancel").click(BILEXICON.closeForms);
            edit.find(".submit").click(submit_edit_form);

            BILEXICON.init_mirror_input(edit);
            edit.fadeIn(function () {
                edit.find("input[type=text]").focus();
            });
        });

        // submit subentry and remove edit form
        function submit_edit_form(event) {
            var edit = $(this).closest(".subentry-edit");
            
            $.ajax({
                url: route + ".js",
                type: "PUT",
                data: edit.find("form").serialize()
            }).success(function (data) {
                resource.replaceWith(data);
                $("#" + resource_id).find(".subentry").effect("highlight");
            }).error(function (jqXHR, textStatus, errorThrown) {
                $(".fieldWithErrors input").unwrap();
                $(".input-error").remove();
                _.each($.parseJSON(jqXHR.responseText), function (error) {
                    var element = edit.find("input[name*='[" + error[0]  + "]']");
                    if (!element.parent().hasClass("fieldWithErrors")) {
                        element
                            .wrap('<span class="fieldWithErrors"/>')
                            .parent()
                            .after('<span class="input-error"/>')
                            .next().html(error[1]);
                    }
                    element.parent().next(".input-error").html(error[1]);
                });
            });

            return false;
        }
    };
}(jQuery));
