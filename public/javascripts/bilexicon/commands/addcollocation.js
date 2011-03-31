/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
/* ------------------------------------------------------------------------
 * add another collocation
 * ------------------------------------------------------------------------ */
BILEXICON.Commands.addCollocation = function () {

  var collocations = jQuery("ol.collocations:first"),
      location = BILEXICON.id_to_path(collocations.attr("id"));

  var retrieveForm = function (data) {
    collocations.append(data);
    var li = collocations.children().last();
    BILEXICON.init_mirror_input(li);

    var createCollocation = function (event) {
      event.preventDefault();

      var r = jQuery.ajax({
          url: location + ".js",
          type: "post",
          data: li.find("form:first").serialize()
      }).success(function (data) {
          li.replaceWith(data);
          var created = collocations.children().last();
          created.effect("highlight");
          var invitation = new BILEXICON.Invitation(created.prevAll(".invitation"),
                                                    BILEXICON.Commands.addCollocation);
      }).error(function (jqXHR, textStatus, errorThrown) {
          jQuery(".fieldWithErrors input").unwrap();
          jQuery(".input-error").remove();
          _.each(jQuery.parseJSON(jqXHR.responseText), function (error) {
              var element = li.find("input[name*='[" + error[0]  + "]']");
              if (!element.parent().hasClass("fieldWithErrors")) {
                  element
                      .wrap('<span class="fieldWithErrors"/>')
                      .parent()
                      .after('<span class="input-error"/>')
                      .next().html(error[1]);
              }
              element.parent().next().html(error[1]);
          });
      });
    };

    var stop = function () {
      li.remove();
      jQuery(document).unbind("closeForms", stop);
    };
    jQuery(document).bind("closeForms", stop);

    li.find(".submit").click(createCollocation);
    li.find(".cancel").click(BILEXICON.closeForms);

    li.fadeIn(function () {
        li.find("input[type=text]:first").focus();
    });
  };


  var r = jQuery.get(location + "/new.js", {}, retrieveForm, 'text');
};

BILEXICON.Commands.cancelAddCollocation = function () {};