/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * edit the current lemma
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.editLemma = function () {

    var lemma = $(".lemma:first"),
        entry = lemma.find(".entry"),
        route = BILEXICON.id_to_path(lemma.attr("id"));

    // show faded entry, fade edit form and remove it
    var stop = function (event) {
        $("#lemma-edit").remove();
        $(".entry:first").show();
        $(document).unbind("closeForms", stop);
    };


    entry.find(".entry-line").addClass("progressing");

    $.when(
        $.ajax({
            url: route + "/edit.js",
            dataType: "text",
            type: "get"
        })
    ).fail(function (jqXHR, textStatus, errorThrown) {
        entry.effect("shake");
    }).done(function (data) {

        $(data).insertAfter(entry);

        BILEXICON.WordClass.show_additional_fields();

        $(document).bind("closeForms", stop);

        $("#lemma_word_class1, #lemma_word_class2").change(BILEXICON.WordClass.show_additional_fields);

        var edit = entry.next();
        edit.find(".cancel").click(BILEXICON.closeForms);
        edit.find(".submit").click(submit_edit_form);

        entry.hide();
        edit.show();
    }).always(function () {
        entry.find(".entry-line").removeClass("progressing");
    });

    ///////////////////////////////////////////////////////////
    // submit entry and dismiss fade edit form and remove it //
    ///////////////////////////////////////////////////////////
    var submit_edit_form = function (event) {
        event.preventDefault();
        var lemma = $(event.target).closest(".lemma");
        var edit = lemma.find(".entry-edit");
        $.ajax({
            url: route + ".js",
            type: "put",
            dataType: "text",
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
};
