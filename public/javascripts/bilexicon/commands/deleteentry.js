/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * delete a lemma or subentry
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.deleteEntry = function (button) {

    var element = button.closest(".subentry, .entry");
    var resource = element.closest("[id]");
    var route = BILEXICON.id_to_path(resource.attr("id"));

    if (confirm('Sind Sie sicher?')) {
        var r = jQuery.ajax({
            url: route, 
            type: "delete"
        }).error(function (jqXHR, textStatus, errorThrown) {
            // TODO
            element.effect("shake");
        }).success(function (data) {
            if (element.hasClass("subentry")) {
                element.fadeOut(function () { resource.remove(); });
            }
            else {
                // TODO
                document.location = "/lemmata";
            }
        });
    }
};
