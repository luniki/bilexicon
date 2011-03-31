/*global $$,$,$w,Ajax,Effect,Element,Prototype,Sortable,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * sort subentries
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.sortEntries = function (button) {

    var collection = button.closest("ol"),
    url = BILEXICON.id_to_path(collection.attr("id")) + "/sort",
    children = collection.children(),
    buttons = collection.find(".multi-button"),
    done = jQuery("#done").clone().removeAttr("id").addClass("done");
    
    jQuery(document).bind("closeForms", stop);

    // show done link and hide the sort triggering multi button
    jQuery(done).insertBefore(collection).click(BILEXICON.closeForms).fadeIn();

    // hide multi buttons of the subentries
    buttons.hide();

    // show drag handles
    children.find(".multi-button")
        .hide()
        .after(jQuery("#drag-handle")
               .clone()
               .removeAttr("id")
               .addClass("drag-handle")
               .show());

    // create sortable and mark accepting area
    collection.sortable({
        axis: 'y',
        items: children,
        placeholder: 'ui-state-highlight column span-24 last',
        forcePlaceholderSize: true,
        handle: ".drag-handle",
        opacity: 0.5,
        tolerance: "pointer"
    });

    collection.addClass("sort-context");

    ///////////////////////////////////////////////////////////////////////////

    function stop () {

        // remove done link and show the sort triggering multi button
        done.remove();
        button.show();

        // show multi buttons of the subentries
        buttons.show();

        // remove drag handles
        jQuery(".drag-handle").remove();

        // destroy sortable and unmark accepting area
        collection.disableSelection();
        collection.removeClass("sort-context");
        jQuery(document).unbind("closeForms", stop);

        // send new order of valencies
        var sequence =_.map(collection.children(), function (element) {
            return element.id.match(/^(?:.*)-(.*)$/)[1];
        });

        jQuery.ajax({
            url: url,
            type: "post",
            data: {sequence: sequence}
        }).error(function (jqXHR, textStatus, errorThrown) {
            // TODO
            collection.effect("shake");
        });
    }
};

BILEXICON.Commands.cancelSorting = function () {};
