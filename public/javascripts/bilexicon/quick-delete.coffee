jQuery ($) ->
  $("body#page-lemmata-show .delete-button").click (event) ->
    item = $(@).closest "li"
    id = item.attr "id"

    # show progress indicator for quick feedback
    # TODO overlay buttons
    item.addClass "progressing"

    # if you delete an subentry, remove all undo statusboxes in the subentry's examples
    item.find(".statusbox").remove()

    # send AJAX request
    # TODO

    # and remove progress indicator as soon as AJAX request is ready
    ajaxSuccess = ->

      nested_progress = item.parent().closest(".progressing").length != 0

      # hide item and remove progress indicator
      item.removeClass("progressing").hide "blind", ->
        unless nested_progress

          # insert status box
          # TODO: Texte kürzen
          forms = form1: item.find(".form1").text(), form2: item.find(".form2").text()

          statusbox = $(JST["lemmata/statusbox"](forms))
            .insertBefore(item)
            .show("blind")
            .find("a.undo")
            .click ->
              # clear timeout, remove status box and show item */
              clearTimeout timeout
              statusbox.remove()
              item.show()
              false
            .end()

          #TODO should be 10 seconds
          timeout = setTimeout (->
            statusbox.remove()
            item.remove()
            ), 5000

    # mocking AJAX
    setTimeout ajaxSuccess, 1000
    false

###

jQuery(function ($) {
    $("body#page-lemmata-show .delete-button").click(function (event) {
        var item = $(this).closest("li");
        var id = item.attr("id");

        // show progress indicator for quick feedback
        // TODO overlay buttons
        item.addClass("progressing");


        // if you delete an subentry, remove all undo statusboxes in the subentry's examples
        item.find(".statusbox").remove();

        // send AJAX request
        // TODO

        // and remove progress indicator as soon as AJAX request is ready
        var ajaxSuccess = function () {

            var nested_progress = item.parent().closest(".progressing").length != 0,
                timeout, forms, statusbox;


            // hide item and remove progress indicator
            item.removeClass("progressing").hide("blind", function () {
                if (!nested_progress) {
                    // insert status box
                    // TODO: Texte kürzen
                    forms = {form1: item.find(".form1").text(), form2: item.find(".form2").text()};
                    statusbox = $(JST["lemmata/statusbox"](forms))
                        .insertBefore(item)
                        .show("blind")
                        .find("a.undo")
                        .click(undoDeletion)
                        .end();
                    //TODO should be 10 seconds
                    timeout = setTimeout(expireUndo, 5000);
                }
            });

            function expireUndo () {
                statusbox.remove();
                item.remove();
            };

            // clear timeout, remove status box and show item
            function undoDeletion () {
                clearTimeout(timeout);
                statusbox.remove();
                item.show();
                return false;
            };
        };

        // mocking AJAX
        setTimeout(ajaxSuccess, 1000);

        return false;
    });
});

###