/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * edit the current lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.editLemma = function () {

    var lemma = jQuery(".lemma:first"),
    entry = lemma.find(".entry"),
    route = BILEXICON.id_to_path(lemma.attr("id"));

    entry.fadeOut();
    
    jQuery.ajax({
        url: route + "/edit.js",
        dataType: "text",
        type: "get"
    }).error(function (jqXHR, textStatus, errorThrown) {
        entry.effect("shake");
    }).success(function (data) {
        jQuery(data).insertAfter(entry);
        
        BILEXICON.WordClass.show_additional_fields();
        
        jQuery("#lemma_word_class1, #lemma_word_class2").change(BILEXICON.WordClass.show_additional_fields);
        
        jQuery(document).bind("closeForms", stop);
        
        var edit = entry.next();
        edit.find(".cancel").click(BILEXICON.closeForms);
        edit.find(".submit").click(submit_edit_form);
        edit.fadeIn();
    });

    //////////////////////////////////////////////////////////////////////

    // submit entry and dismiss fade edit form and remove it
    var submit_edit_form = function (event) {
        event.preventDefault();
        var lemma = jQuery(event.target).closest(".lemma");
        var edit = lemma.find(".entry-edit");
        jQuery.ajax({
            url: route + ".js",
            type: "put",
            data: edit.find("form").serialize()
        }).success(function (data) {
            edit.remove();
            lemma.find(".entry").replaceWith(data);
            lemma.find(".entry-line").effect("highlight");
        }).error(function (jqXHR, textStatus, errorThrown) {
            edit.replaceWith(jqXHR.responseText);
            edit = lemma.find(".entry-edit");
            edit.find(".cancel").click(BILEXICON.closeForms);
            edit.find(".submit").click(submit_edit_form);
            edit.show();
        });
    };

    // show faded entry, fade edit form and remove it
    var stop = function (event) {
        var edit = jQuery("#lemma-edit"), entry = jQuery(".entry:first");
        edit.remove();
        entry.fadeIn();
        jQuery(document).unbind("closeForms", stop);
    };
};
