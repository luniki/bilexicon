/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * multi button
 * ------------------------------------------------------------------------ */
BILEXICON.MultiButton = (function ($) {

    return {

        setup: function () {
            this.menu = $("#multi-button-menu");
            if (!this.menu.length) {
                return;
            }
            this.activeButton = false;

            this.menu.click(_.bind(this.observeMenu, this));
            $(document).click(_.bind(this.observeDocument, this));
            this.clickOffObserver = _.bind(this.clickOff, this);
        },

        observeDocument: function (event) {

            var multibutton = $(event.target).closest(".multi-button");
            if (!multibutton.length) {
                return;
            }

            event.preventDefault();
            event.stopPropagation();

            if (this.activeButton) {
                this.clickOff();
                if (this.activeButton === multibutton) {
                    return;
                }
            }

            this.activeButton = multibutton;

            this.activeButton.addClass("active-multi-button");
            this.showMenu(this.activeButton);

            $(document).click(this.clickOffObserver);
        },

        observeMenu: function (event) {

            event.preventDefault();
            event.stopPropagation();

            BILEXICON.closeForms();

            var command = $(event.target).closest("li").attr("class").match(/^cmd\-([a-zA-Z]+)/)[1];
            BILEXICON.Commands[command](this.activeButton);
            this.clickOff();
        },

        hideMenu: function (button) {
            this.menu.find("ul:first").css({ minWidth: "0px" });
            this.menu.hide();
        },


        clickOff: function (event) {
            this.hideMenu(this.activeButton);
            this.activeButton.removeClass("active-multi-button");
            this.activeButton = false;
            $(document).unbind("click", this.clickOffObserver);
        },

        showMenu: function (button) {

            var button_offset = button.offset();
            button_offset.left -= 7;
            button_offset.top += button.height();

            var button_width = this.activeButton.width();

            this.menu.css({
                top: button_offset.top + "px",
                left: button_offset.left + "px"
            });

            var parse = function (value) {
                return parseFloat(value.match(/^([\+\-]?[0-9\.]+)(.*)$/)[1]);
            };

            var ul = this.menu.find("ul:first");
            button_width = button_width -
                parse(ul.css("border-left-width")) -
                parse(ul.css("border-right-width")) -
                parse(ul.css("padding-left")) -
                parse(ul.css("padding-right"));
            ul.css({ minWidth: button_width + "px" });

            this.menu.find("div:first").attr("class", button.attr("class"));
            this.menu.show();
        }
    };
}(jQuery));
