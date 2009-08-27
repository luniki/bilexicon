/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
BILEXICON.WordClass = (function () {

  var last_word_classes = [];

  var get_word_classes = function () {
    return [1, 2].collect(function (side) {
      return $("lemma_word_class" + side);
    }).pluck("value").invoke("toLowerCase");
  };


  var show_additional_fields = function () {

    var new_word_classes = get_word_classes();

    // hide fields of old class
    [0, 1].each(function (index) {

      var other = index === 0 ? 1 : 0,
          last = last_word_classes[index],
          segment = $("additional-" + last);

      // this side changed
      if (last && last !== new_word_classes[index] && segment) {

        // segment should still be shown, but remove the previous fields
        if (last === new_word_classes[other]) {
          segment.select(".form" + (index + 1)).invoke("removeVisibility");
        }

        // segment should vanish and the other side's fields should be shown
        else {
          segment.hide();
          segment.select(".form" + (other + 1)).invoke("setVisibility");
        }
      }
    });

    // show new fields
    [0, 1].each(function (index) {

      var other = index === 0 ? 1 : 0,
          segment = $("additional-" + new_word_classes[index]);

      if (segment) {

        segment.show();

        if (new_word_classes[index] !== new_word_classes[other]) {
          segment.select(".form" + (other + 1)).invoke("removeVisibility");
        }
        else {
          segment.select(".form" + (index + 1)).invoke("setVisibility");
        }
      }

    });

    last_word_classes = new_word_classes;
  };


  return {
    get_word_classes: get_word_classes,
    show_additional_fields: show_additional_fields
  };
}());

document.observe("dom:loaded", function () {
  if ($("new_lemma")) {
    BILEXICON.WordClass.show_additional_fields();
    [1, 2].each(function (side) {
      $("lemma_word_class" + side).observe("change", BILEXICON.WordClass.show_additional_fields);
    });
  }
});
