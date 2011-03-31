/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */
BILEXICON.WordClass = (function ($) {

    var last_word_classes = [];

    var get_word_classes = function () {
        return _.invoke(
            _.map([1, 2], function (side) {
                return $("#lemma_word_class" + side).val();
            }),
            "toLowerCase");
    };


    var show_additional_fields = function () {

        var new_word_classes = get_word_classes();

        // hide fields of old class
        _.times(2, function (index) {

            var other = index === 0 ? 1 : 0,
            last = last_word_classes[index],
            segment = $("#additional-" + last);

            // this side changed
            if (last && last !== new_word_classes[index] && segment) {

                // segment should still be shown, but remove the previous fields
                if (last === new_word_classes[other]) {
                    $(".form" + (index + 1), segment)
                        .css({"visibility": "hidden"})
                        .find("input, textarea, select")
                        .attr("disabled", "disabled");
                }

                // segment should vanish and the other side's fields should be shown
                else {
                    $(segment)
                        .hide()
                        .find("input, textarea, select")
                        .attr("disabled", "disabled");
                    $(segment)
                        .find(".form" + (other + 1), segment)
                        .css({"visibility": "visible"});
                }
            }
        });

        // show new fields
        _.times(2, function (index) {

            var other = index === 0 ? 1 : 0,
            segment = $("#additional-" + new_word_classes[index]);

            if (segment) {

                segment = $(segment).show();

                if (new_word_classes[index] !== new_word_classes[other]) {
                    segment.find(".form" + (index + 1))
                        .find(":disabled")
                        .removeAttr("disabled");
                    segment.find(".form" + (other + 1))
                        .css({visibility: "hidden"})
                        .find("input, textarea, select")
                        .attr("disabled", "disabled");
                }
                else {
                    segment.find(".form" + (index + 1))
                        .css({visibility: "visible"})
                        .find(":disabled")
                        .removeAttr("disabled");
                }
            }

        });

        last_word_classes = new_word_classes;
    };


    return {
        get_word_classes: get_word_classes,
        show_additional_fields: show_additional_fields
    };
}(jQuery));

jQuery(function ($) {
    if ($("form.new_lemma, form.edit_lemma").length > 0) {
        BILEXICON.WordClass.show_additional_fields();
        _.each([1, 2], function (side) {
            $("#lemma_word_class" + side).change(BILEXICON.WordClass.show_additional_fields);
        });
    }
});
