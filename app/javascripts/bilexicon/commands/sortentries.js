/*global $$,$,$w,Ajax,Effect,Element,Prototype,Sortable,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * sort subentries
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.sortEntries = function (button) {

  var collection = button.up("ol"),
      url = BILEXICON.id_to_path(collection.id) + "/sort",
      children = collection.childElements(),
      buttons = collection.select(".multi-button"),
      done = $("done").cloneNode(true)
                      .writeAttribute({id: null})
                      .addClassName("done");

  var stop = function () {

    // remove done link and show the sort triggering multi button
    done.remove();
    button.show();

    // show multi buttons of the subentries
    buttons.invoke("show");

    // remove drag handles
    $$(".drag-handle").invoke("remove");

    // send new order of valencies
    var request = new Ajax.Request(url, {
      parameters: Sortable.serialize(collection.id, {"name": "sequence"}) +
                  '&authenticity_token=' + BILEXICON.token,
      onFailure: function () {
        // TODO
        collection.shake();
      }
    });

    // destroy sortable and unmark accepting area
    Sortable.destroy(collection.id);
    collection.removeClassName("sort-context");

    document.stopObserving("close:forms", stop);
  };

  document.observe("close:forms", stop);

  // show done link and hide the sort triggering multi button
  collection.insert({ before: done.appear({afterSetup: Element.scrollTo.curry(done)}).observe("click", BILEXICON.closeForms) });

  // hide multi buttons of the subentries
  buttons.invoke("hide");

  // show drag handles
  children.invoke("down", ".multi-button").each(function (mb) {
    mb.hide().insert({
      after: $("drag-handle").cloneNode(true)
                              .writeAttribute({id: null})
                              .addClassName("drag-handle")
                              .show()
    });
  });

  // create sortable and mark accepting area
  Sortable.create(collection.id, {
    elements: children,
    ghosting: true,
    tag: "li",
    format: /^(?:.*)-(.*)$/,
    handle: "drag-handle"
  });
  collection.addClassName("sort-context");
};

BILEXICON.Commands.cancelSorting = Prototype.emptyFunction;

