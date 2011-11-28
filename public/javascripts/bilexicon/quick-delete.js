(function() {
  jQuery(function($) {
    $("body#page-lemmata-show .delete-button").live("click", function(event) {
      $(this).closest("li").addClass("confirm-delete");
      return false;
    });
    $(".really-delete .cancel").live("click", function() {
      $(this).closest("li").removeClass("confirm-delete");
      return false;
    });
    return $(".really-delete .accept").live("click", function() {
      var item;
      item = $(this).closest("li");
      item.addClass("progressing").removeClass("confirm-delete");
      return $.ajax({
        url: BILEXICON.id_to_path(item.attr("id")),
        type: "delete"
      }).error(function(jqXHR, textStatus, errorThrown) {
        return item.effect("shake").removeClass("confirm-delete");
      }).success(function(data) {
        return item.hide("blind", function() {
          return item.remove();
        });
      });
    });
  });
}).call(this);
