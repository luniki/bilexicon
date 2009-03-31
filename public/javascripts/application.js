// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

(function(){
  var methods = {
    defaultValueActsAsHint: function(element){
      element = $(element);
      element._default = element.value;

      return element.observe('focus', function(){
        if(element._default != element.value) return;
        element.removeClassName('hint').value = '';
      }).observe('blur', function(){
        if(element.value.strip() != '') return;
        element.addClassName('hint').value = element._default;
      }).addClassName('hint');
    }
  };

  $w('input textarea').each(function(tag){ Element.addMethods(tag, methods) });
})();


/* ------------------------------------------------------------------------
 * the global BILEXICON namespace
 * ------------------------------------------------------------------------ */
if (typeof BILEXICON == "undefined" || !BILEXICON) {
    var BILEXICON = {};
}

/* ------------------------------------------------------------------------
 * popup for other search engines on lemmata search page
 * ------------------------------------------------------------------------ */
BILEXICON.SearchPopup = function(event) {

    event.stop();

    var q = $('search_term').innerHTML;
    var increment = 20;
    var popup = function() {
      ['http://pons.eu/dict/search/results/?l=deen&q=',
        'http://dict.leo.org/ende?search=',
        'http://www.dict.cc/?s=',
        'http://dict.tu-chemnitz.de/dings.cgi?query='].reverse().each(
        function(url) {
          window.open(url + encodeURIComponent(q), url.gsub(/\W/, ""),
                      "height=400,width=600,top=" + increment +",left=" + increment);
          increment += 25;
        }
      );
    };

    popup();
};

/* ------------------------------------------------------------------------
 * dom:loaded events
 * ------------------------------------------------------------------------ */
document.observe("dom:loaded", function() {
  $("popup-search").observe("click", BILEXICON.SearchPopup);
});
