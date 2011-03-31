/* ------------------------------------------------------------------------
 * form helpers
 * ------------------------------------------------------------------------ */
BILEXICON.init_mirror_input = function (root) {
  jQuery("input[class~='mirror-input']", root || document.body).each(function (index) {
    var from = jQuery(this);
    // find classes starting with "to-"
    var classNames = _.select(from.attr("class").split(" "), function (klass) {
        return klass.match(/^to-/);
    });
      
    // and bind mirroring callback on blur
    _.each(classNames, function (klass) {
        var to = jQuery("#" + klass.substr(3));
        from.blur(function (event) {
            if (to.val() === '') {
                to.val(from.val());
            }
        });
    });
  });
};

BILEXICON.id_to_path = function (id) {
  return "/" + id.replace(/-/g, "/");
};
