jQuery ($) ->

  # switch to Confirm Deletion view
  $("body#page-lemmata-show .delete-button").live "click", (event) ->
    $(@).closest("li").addClass "confirm-delete"
    false

  # handle #cancel clicks
  $(".really-delete .cancel").live "click", ->
    $(@).closest("li").removeClass "confirm-delete"
    false

  # handle #accept clicks
  $(".really-delete .accept").live "click", ->
    item = $(@).closest "li"

    # show progress indicator for quick feedback
    item.addClass("progressing").removeClass("confirm-delete")

    $.ajax
      url: BILEXICON.id_to_path(item.attr("id")) + ".js"
      type: "delete"
    .error (jqXHR, textStatus, errorThrown) ->
      item.effect("shake").removeClass "confirm-delete"
    .success (data) ->
      item.hide "blind", -> item.remove()
