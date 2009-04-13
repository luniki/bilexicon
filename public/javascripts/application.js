// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*global $,$w,Element */
/*jslint white: true */


(function () {
  var methods = {
    defaultValueActsAsHint: function (element) {
      element = $(element);
      element._default = element.value;

      return element.observe('focus', function () {
        if (element._default != element.value) {
          return;
        }
        element.removeClassName('hint').value = '';
      }).observe('blur', function () {
        if (element.value.strip() !== '') {
          return;
        }
        element.addClassName('hint').value = element._default;
      }).addClassName('hint');
    }
  };

  $w('input textarea').each(function (tag) {
    Element.addMethods(tag, methods);
  });
})();


/* ------------------------------------------------------------------------
 * the global BILEXICON namespace
 * ------------------------------------------------------------------------ */
var BILEXICON = {};


/* ------------------------------------------------------------------------
 * Special FX
 * ------------------------------------------------------------------------ */
Effect.SelfHealingFade = function (element) {
  element = $(element);
  return new Effect.Parallel(
    [
      new Effect.Fade(element,  { sync: true }),
      new Effect.BlindUp(element, { sync: true })
    ],
    arguments[1] || { duration: 0.25 }
  );
};

Effect.SelfHealingAppear = function (element) {
  element = $(element);
  return new Effect.Parallel(
    [
      new Effect.Appear(element,  { sync: true }),
      new Effect.BlindDown(element, { sync: true })
    ],
    arguments[1] || { duration: 0.25 }
  );
};


/* ------------------------------------------------------------------------
 * popup for other search engines on lemmata search page
 * ------------------------------------------------------------------------ */
BILEXICON.SearchPopup = function (event) {

  event.stop();

  var q = $('search_term').innerHTML;
  var increment = 20;
  var popup = function () {
    ['http://pons.eu/dict/search/results/?l=deen&q=',
      'http://dict.leo.org/ende?search=',
      'http://www.dict.cc/?s=',
      'http://dict.tu-chemnitz.de/dings.cgi?query='].reverse().each(
      function (url) {
        window.open(url + encodeURIComponent(q), url.gsub(/\W/, ""),
                    "height=400,width=600,top=" + increment + ",left=" + increment);
        increment += 25;
      }
    );
  };

  popup();
};

/* ------------------------------------------------------------------------
 * multi button
 * ------------------------------------------------------------------------ */
BILEXICON.MultiButton = function () {

  var edit_templates = {};

  // initializes the edit templates
  function init_edit_templates() {
    $w("examples valencies").each(function (type) {
      var comment =
        $A($(type + "-edit-template").childNodes).find(function (c) {
          return c.nodeType === Node.COMMENT_NODE;
        });
      if (comment) {
        edit_templates[type] = new Template(comment.nodeValue);
      }
    });
  }

  var cmds = {

    "edit" : function (button) {

      var subentry = button.up(".subentry");
      var resource = subentry.up("*[id]");
      var type = resource.id.match(/(\w+)\/\d+$/)[1];

      // show faded subentry, fade edit form and remove it
      var cancel_edit_form = function (event) {
        var edit = event.element().up(".subentry-edit");
        Effect.SelfHealingFade(edit, {
          afterFinish: Element.remove.curry(edit)
        });
        Effect.SelfHealingAppear(subentry);
        event.stop();
      };

      // submit subentry and dismiss fade edit form and remove it
      var submit_edit_form = function (event) {
        var edit = event.element().up(".subentry-edit");
        var r = new Ajax.Request(resource.id, {
          method: "put",
          parameters: edit.down("form").serialize(true),
          onSuccess: function (transport) {
            var id = resource.id;
            resource.replace(transport.responseText);
            $(id).down(".subentry").highlight();
          },
          onFailure: function (transport) {
            // TODO
          }
        });
        event.stop();
      };


      Effect.SelfHealingFade(subentry);

      var r = new Ajax.Request(resource.id + ".json", {
        method: "get",

        onFailure: function (transport) {
          // TODO
        },

        onSuccess: function (transport) {
          subentry.insert({
            after:  edit_templates[type].evaluate(transport.responseJSON)
          });
          var edit = subentry.next();
          edit.down(".cancel").observe("click", cancel_edit_form);
          edit.down(".submit").observe("click", submit_edit_form);
          Effect.SelfHealingAppear(edit);
        }
      });
    },

    "delete": function (button) {
      var subentry = button.up(".subentry");
      var resource = subentry.up("*[id]");
      var type = resource.id.match(/(\w+)\/\d+$/)[1];


      if (confirm('Sind Sie sicher?')) {
        var r = new Ajax.Request(resource.id, {
          method: "delete",
          parameters: {authenticity_token: BILEXICON.token},
          onFailure: function (transport) {
            subentry.shake();
          },
          onSuccess: function (transport) {
            Effect.SelfHealingFade(subentry, {
              duration: 0.25,
              afterFinish: Element.remove.curry(subentry)
            });
          }
        });
      }
    },

    "add-example":  function (button) {
      var location = this.activeButton.up("*[id]").id;
    }
  };


  return {

    setup: function () {
      this.menu = $("multi-button-menu");
      if (!this.menu) {
        return;
      }
      this.activeButton = false;
      init_edit_templates();

      this.menu.observe("click", this.observeMenu.bindAsEventListener(this));
      document.observe("click", this.observeDocument.bindAsEventListener(this));
      this.clickOffObserver = this.clickOff.bindAsEventListener(this);
    },

    observeDocument: function (event) {
      var multibutton = event.findElement(".multi-button");
      if (!multibutton) {
        return false;
      }
      event.stop();

      if (this.activeButton && this.activeButton != multibutton) {
        this.clickOff();
      } else if (this.activeButton && this.activeButton == multibutton) {
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
      var class_name = event.findElement("li").className;
      if (Prototype.Browser.IE) {
        class_name = class_name.replace(/\b\w*hover_/gi, "").strip();
      }
      var c = class_name.match(/^cmd\-([a-z\-]+)$/)[1];
      cmds[c](this.activeButton);
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

      var _60 = button.className;
      this.menu.down("div").className = _60;

      this.menu.show();
    }
  };
}();

/* ------------------------------------------------------------------------
 * dom:loaded events
 * ------------------------------------------------------------------------ */
document.observe("dom:loaded", function () {

  if ($("search_input")) {
    $('search_input').defaultValueActsAsHint();
  }

  if ($("popup-search")) {
    $("popup-search").observe("click", BILEXICON.SearchPopup);
  }

  BILEXICON.MultiButton.setup();
});

