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
 * form helpers
 * ------------------------------------------------------------------------ */
BILEXICON.mirror_input = function (from, to) {
  from = $(from);
  to = $(to);
  from.observe("blur", function (event) {
    if (to.value === '') {
      to.value = from.value;
    }
  });
};

BILEXICON.init_mirror_input = function (root) {
  root = root || document.body;
  root.select("input[class~='mirror-input']").each(function (from) {
    from.classNames().grep(/^to-/).each(function (to) {
      BILEXICON.mirror_input(from, to.substr(3));
    });
  });
};


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
    $w("examples valencies collocations phraseologisms").each(function (type) {
      var comment =
        $A($(type + "-edit-template").childNodes).find(function (c) {
          return c.nodeType === Node.COMMENT_NODE;
        });
      if (comment) {
        edit_templates[type] = new Template(comment.nodeValue);
      }
    });
  }

  var id_to_path = function (id) {
    return "/" + id.gsub("-", "/");
  };

  var cmds = {

    "edit-lemma" : function (button) {

      var entry = button.up(".entry"),
          resource = entry.up("*[id]"),
          route = id_to_path(resource.id);

      // show faded entry, fade edit form and remove it
      var cancel_edit_form = function (event) {
        var edit = event.element().up(".entry-edit");
        Effect.SelfHealingFade(edit, {
          afterFinish: Element.remove.curry(edit)
        });
        Effect.SelfHealingAppear(entry);
        event.stop();
      };

      // submit entry and dismiss fade edit form and remove it
      var submit_edit_form = function (event) {
        var lemma = event.element().up(".lemma");
        var edit = lemma.down(".entry-edit");
        var r = new Ajax.Request(route, {
          method: "put",
          parameters: edit.down("form").serialize(true),
          onSuccess: function (transport) {
            edit.remove();
            resource.down(".entry").replace(transport.responseText);
            resource.down(".entry-line").highlight();
          },
          onFailure: function (transport) {
            edit.replace(transport.responseText);
            edit = lemma.down(".entry-edit");
            edit.down(".cancel").observe("click", cancel_edit_form);
            edit.down(".submit").observe("click", submit_edit_form);
            edit.show();
          }
        });
        event.stop();
      };


      Effect.SelfHealingFade(entry);

      var r = new Ajax.Request(route + "/edit", {
        method: "get",

        onFailure: function (transport) {
          // TODO
          entry.shake();
        },

        onSuccess: function (transport) {
          entry.insert({ after:  transport.responseText });
          var edit = entry.next();
          edit.down(".cancel").observe("click", cancel_edit_form);
          edit.down(".submit").observe("click", submit_edit_form);
          Effect.SelfHealingAppear(edit);
        }
      });
    },


    "edit" : function (button) {

      var subentry = button.up(".subentry"),
          resource = subentry.up("*[id]"),
          route = id_to_path(resource.id),
          type = resource.id.match(/(\w+)-\d+$/)[1];

      // show faded subentry, fade edit form and remove it
      var cancel_edit_form = function (event) {
        var edit = event.element().up(".subentry-edit");
        Effect.SelfHealingFade(edit, {
          afterFinish: Element.remove.curry(edit)
        });
        Effect.SelfHealingAppear(subentry);
        event.stop();
      };

      // submit subentry and remove edit form
      var submit_edit_form = function (event) {
        var edit = event.element().up(".subentry-edit");
        var r = new Ajax.Request(route, {
          method: "put",
          parameters: edit.down("form").serialize(true),

          // replace resource with response and highlight it
          onSuccess: function (transport) {
            var id = resource.id;
            resource.replace(transport.responseText);
            $(id).down(".subentry").highlight();
          },

          // get errors from response and show them on the invalid fields
          onFailure: function (transport) {
            var errors = transport.responseText.evalJSON();
            errors.each(function (error) {
              var element = edit.down("input[name*='[" + error[0]  + "]']");
              if (!element.parentNode.hasClassName("fieldWithErrors")) {
                element.wrap("span", {"class": "fieldWithErrors"}).insert({
                  after: new Element("span", {"class": "input-error"})
                         .update(error[1])
                });
              }
              element.parentNode.next(".input-error").update(error[1]);
            });
          }
        });
        event.stop();
      };


      Effect.SelfHealingFade(subentry);

      var r = new Ajax.Request(route + ".json", {
        method: "get",

        onFailure: function (transport) {
          // TODO
          subentry.shake();
        },

        onSuccess: function (transport) {
          subentry.insert({
            after:  edit_templates[type].evaluate(transport.responseJSON)
          });
          var edit = subentry.next();
          edit.down(".cancel").observe("click", cancel_edit_form);
          edit.down(".submit").observe("click", submit_edit_form);
          BILEXICON.init_mirror_input(edit);
          Effect.SelfHealingAppear(edit);
        }
      });
    },

    "delete": function (button) {
      var element = button.up(".subentry, .entry");
      var resource = element.up("*[id]");
      var route = id_to_path(resource.id);

      if (confirm('Sind Sie sicher?')) {
        var r = new Ajax.Request(route, {
          method: "delete",
          parameters: {authenticity_token: BILEXICON.token},
          onFailure: function (transport) {
            // TODO
            element.shake();
          },
          onSuccess: function (transport) {
            if (element.hasClassName("subentry")) {
              Effect.SelfHealingFade(element, {
                duration: 0.25,
                afterFinish: Element.remove.curry(resource)
              });
            }
            else {
              document.location = "/lemmata";
            }
          }
        });
      }
    },

    "add-example":  function (button) {
      var location = id_to_path(button.up("*[id]").id);
      document.location = location + "/examples/new";
    },

    "add-collocation":  function (button) {
      var location = id_to_path(button.up("*[id]").id);
      document.location = location + "/collocations/new";
    },

    "add-phraseologism":  function (button) {
      var location = id_to_path(button.up("*[id]").id);
      document.location = location + "/phraseologisms/new";
    },

    "add-valency":  function (button) {
      var location = id_to_path(button.up("*[id]").id);
      document.location = location + "/valencies/new";
    },

    "sort": function (button) {

      var collection = button.up("ol"),
          url = id_to_path(collection.id) + "/sort",
          children = collection.childElements(),
          buttons = collection.select(".multi-button"),
          done = $("done").cloneNode(true)
                          .writeAttribute({id: null})
                          .addClassName("done");

      var finalize = function (event) {
        event.stop();

        // remove done link and show the sort triggering multi button
        done.remove();
        button.show();

        // show multi buttons of the subentries
        buttons.invoke("show");

        // remove drag handles
        $$(".drag-handle").invoke("remove");

        // send new order of valencies
        var request = new Ajax.Request(url, {
          parameters: Sortable.serialize(collection.id, {"name": "sequence"}) +
                      '&authenticity_token=' + BILEXICON.token,
          onFailure: function () {
            // TODO
            collection.shake();
          }
        });

        // destroy sortable and unmark accepting area
        Sortable.destroy(collection.id);
        collection.setStyle({ border: "none" });
      };

      // show done link and hide the sort triggering multi button
      collection.insert({ before: done.appear().observe("click", finalize) });

      // hide multi buttons of the subentries
      buttons.invoke("hide");

      // show drag handles
      children.invoke("down", ".multi-button").each(function (mb) {
        mb.hide().insert({
          after: $("drag-handle").cloneNode(true)
                                 .writeAttribute({id: null})
                                 .addClassName("drag-handle")
                                 .show()
        });
      });

      // create sortable and mark accepting area
      Sortable.create(collection.id, {
        elements: children,
        ghosting: true,
        tag: "li",
        format: /^(?:.*)\/(.*)$/,
        handle: "drag-handle"
      });
      collection.setStyle({ border: "1px dashed #eee" });
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

  BILEXICON.init_mirror_input();

  BILEXICON.MultiButton.setup();
});

