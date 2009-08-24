/*global $$,$,$w,Ajax,Effect,Element,Prototype,BILEXICON */
/*jslint browser: true, white: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, newcap: true, immed: true */

/* ------------------------------------------------------------------------
 * multi button
 * ------------------------------------------------------------------------ */
BILEXICON.MultiButton = (function () {

  return {

    setup: function () {
      this.menu = $("multi-button-menu");
      if (!this.menu) {
        return;
      }
      this.activeButton = false;

      this.menu.observe("click", this.observeMenu.bind(this));
      document.observe("click", this.observeDocument.bind(this));

      this.clickOffObserver = this.clickOff.bind(this);
    },

    observeDocument: function (event) {
      var multibutton = event.findElement(".multi-button");
      if (!multibutton) {
        return false;
      }
      event.stop();

      if (this.activeButton && this.activeButton !== multibutton) {
        this.clickOff();
      } else if (this.activeButton && this.activeButton === multibutton) {
        this.clickOff();
        return;
      }

      this.activeButton = multibutton;

      this.activeButton.addClassName("active-multi-button");

      this.showMenu(this.activeButton);

      document.observe("click", this.clickOffObserver);
    },

    observeMenu: function (event) {

      event.stop();
      BILEXICON.closeForms();

      var class_name = event.findElement("li").className;
      if (Prototype.Browser.IE) {
        class_name = class_name.replace(/\b\w*hover_/gi, "").strip();
      }
      var c = class_name.match(/^cmd\-([a-zA-Z]+)$/)[1];
      BILEXICON.Commands[c](this.activeButton);
      this.clickOff();
    },

    hideMenu: function (button) {
      var tr = button.up("tr");
      if (tr) {
        tr.removeClassName("open");
      }
      this.menu.down("ul").setStyle({ minWidth: "0px" });
      this.menu.hide();
    },


    clickOff: function () {
      this.hideMenu(this.activeButton);
      this.activeButton.removeClassName("active-multi-button");
      this.activeButton = false;
      document.stopObserving("click", this.clickOffObserver);
    },

    showMenu: function (button) {

      var button_offset = button.cumulativeOffset();
      var page_offset = document.body.cumulativeOffset();

      button_offset.left = button_offset.left - 7 - page_offset.left;
      button_offset.top = button_offset.top + button.getHeight() - page_offset.top;

      var button_width = this.activeButton.getWidth();

      this.menu.setStyle({
        top: button_offset.top + "px",
        left: button_offset.left + "px"
      });

      var parse = function (value) {
        return parseFloat(value.match(/^([\+\-]?[0-9\.]+)(.*)$/)[1]);
      };

      var ul = this.menu.down("ul");
      button_width = button_width -
                     parse(ul.getStyle("border-left-width")) -
                     parse(ul.getStyle("border-right-width")) -
                     parse(ul.getStyle("padding-left")) -
                     parse(ul.getStyle("padding-right"));
      ul.setStyle({ minWidth: button_width + "px" });

      var button_class = button.className;
      this.menu.down("div").className = button_class;

      this.menu.show();
    }
  };
}());

