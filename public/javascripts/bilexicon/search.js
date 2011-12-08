(function() {

  /*
  popup for other search engines on lemmata search page
  */

  var gbook, searchPopup, validateSearch;

  searchPopup = function(event) {
    var increment, index, q, site, sites, _len, _results;
    if (event != null) event.preventDefault();
    q = encodeURIComponent($('#search_term').text());
    sites = ['http://dict.tu-chemnitz.de/dings.cgi?query=', 'http://www.dict.cc/?s=', 'http://dict.leo.org/ende?search=', 'http://pons.eu/dict/search/results/?l=deen&q='];
    _results = [];
    for (index = 0, _len = sites.length; index < _len; index++) {
      site = sites[index];
      increment = 25 * index;
      _results.push(window.open(site + q, site.replace(/\W/, ""), "height=400,width=600,top=" + increment + ",left=" + increment));
    }
    return _results;
  };

  validateSearch = function(input) {
    var search;
    search = $(input);
    return search.closest("form").submit(function(event) {
      if (search.val() === "") {
        event.preventDefault();
        return search.effect("highlight", {
          color: "#ff0000"
        });
      }
    });
  };

  gbook = function(event) {
    var height, index, lang, q, site, subentry, width, _len, _ref, _results;
    subentry = $(this).closest(".subentry");
    height = 400;
    width = 600;
    _ref = ["en", "de"];
    _results = [];
    for (index = 0, _len = _ref.length; index < _len; index++) {
      lang = _ref[index];
      q = subentry.find(".form" + (index + 1)).text().trim();
      site = "http://www.google.com/search?lr=lang_" + lang + "&tbm=bks&q=" + (encodeURIComponent(q));
      _results.push(window.open(site, site.replace(/\W/, ""), "height=" + height + ",width=" + width + ",top=0,left=" + ((width + 20) * index)));
    }
    return _results;
  };

  jQuery(function($) {
    $("#popup-search").click(searchPopup);
    validateSearch("#search_input");
    return $(".gbook-button").live("click", gbook);
  });

}).call(this);
