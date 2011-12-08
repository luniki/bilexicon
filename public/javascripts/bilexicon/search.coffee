###
popup for other search engines on lemmata search page
###

searchPopup = (event) ->

  event?.preventDefault()

  q = encodeURIComponent $('#search_term').text()

  sites = [
    'http://dict.tu-chemnitz.de/dings.cgi?query='
    'http://www.dict.cc/?s='
    'http://dict.leo.org/ende?search='
    'http://pons.eu/dict/search/results/?l=deen&q='
    ]

  for site, index in sites
    increment = 25 * index
    window.open site + q, site.replace(/\W/, ""),
                "height=400,width=600,top=#{increment},left=#{increment}"

validateSearch = (input) ->
  search = $ input
  search.closest("form").submit (event) ->
    if search.val() == ""
      event.preventDefault();
      search.effect "highlight", color:"#ff0000"

gbook = (event) ->
  subentry = $(this).closest(".subentry")

  height = 400
  width = 600

  for lang, index in ["en", "de"]
    q = subentry.find(".form#{index + 1}").text().trim()
    site = "http://www.google.com/search?lr=lang_#{lang}&tbm=bks&q=#{encodeURIComponent q}";
    window.open site, site.replace(/\W/, ""),
                "height=#{height},width=#{width},top=0,left=#{(width + 20) * index}"

jQuery ($) ->

    # search popup
    $("#popup-search").click searchPopup

    # seach field
    validateSearch "#search_input"

    # google books button
    $(".gbook-button").live "click", gbook
