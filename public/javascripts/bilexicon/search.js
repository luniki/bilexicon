/* ------------------------------------------------------------------------
 * popup for other search engines on lemmata search page
 * ------------------------------------------------------------------------ */
BILEXICON.SearchPopup = function (event) {

  event.stop();

  var q = $('search_term').innerHTML;
  var increment = 20;
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

document.observe("dom:loaded", function () {
  if ($("popup-search")) {
    $("popup-search").observe("click", BILEXICON.SearchPopup);
  }

  if ($("search_input")) {
    var search = $("search_input"),
        form = search.up("form").observe("submit", function (event) {
          if (search.hasClassName("hint") || search.value === "") {
            event.stop();
            search.shake();
          }
    });
  }
});
