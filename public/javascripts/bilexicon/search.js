/* ------------------------------------------------------------------------
 * popup for other search engines on lemmata search page
 * ------------------------------------------------------------------------ */
BILEXICON.SearchPopup = function (event) {

    if (event) {
        event.preventDefault();
    }

    var q = jQuery('#search_term').text();
    var increment = 20;
    _.each([
        'http://dict.tu-chemnitz.de/dings.cgi?query=',
        'http://www.dict.cc/?s=',
        'http://dict.leo.org/ende?search=',
        'http://pons.eu/dict/search/results/?l=deen&q='
    ], function (url) {
        window.open(url + encodeURIComponent(q), url.gsub(/\W/, ""),
                    "height=400,width=600,top=" + increment + ",left=" + increment);
        increment += 25;
    });
};

jQuery(function ($) {
    $("#popup-search").click(BILEXICON.SearchPopup);

    $("#search_input").closest("form").submit(function (event) {
        if ($(this).val() === "") {
            event.preventDefault();
            search.shake();
        }
    });
});
