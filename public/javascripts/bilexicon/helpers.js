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

BILEXICON.id_to_path = function (id) {
  return "/" + id.gsub("-", "/");
};

