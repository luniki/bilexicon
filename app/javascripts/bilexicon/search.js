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

