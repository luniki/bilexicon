(function() {
  jQuery(function($) {
    return $("body#page-lemmata-show .delete-button").click(function(event) {
      var ajaxSuccess, id, item;
      item = $(this).closest("li");
      id = item.attr("id");
      item.addClass("progressing");
      item.find(".statusbox").remove();
      ajaxSuccess = function() {
        var nested_progress;
        nested_progress = item.parent().closest(".progressing").length !== 0;
        return item.removeClass("progressing").hide("blind", function() {
          var forms, statusbox, timeout;
          if (!nested_progress) {
            forms = {
              form1: item.find(".form1").text(),
              form2: item.find(".form2").text()
            };
            statusbox = $(JST["lemmata/statusbox"](forms)).insertBefore(item).show("blind").find("a.undo").click(function() {
              clearTimeout(timeout);
              statusbox.remove();
              item.show();
              return false;
            }).end();
            return timeout = setTimeout((function() {
              statusbox.remove();
              return item.remove();
            }), 5000);
          }
        });
      };
      setTimeout(ajaxSuccess, 1000);
      return false;
    });
  });
  /*
  
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
  
  */
}).call(this);
