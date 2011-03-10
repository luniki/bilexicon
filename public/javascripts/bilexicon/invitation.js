/* ------------------------------------------------------------------------
 * invitation
 * ------------------------------------------------------------------------ */
BILEXICON.Invitation = Class.create({

  initialize: function(element, action) {
    this.element = element;
    this.action = action;

    this.addObservers();
    BILEXICON.Invitation.removeAll();
    BILEXICON.Invitation.add(this);
  },

  addObservers: function () {
    this.element.down(".accept").observe("click", this.accept.bind(this));
    this.element.down(".cancel").observe("click", this.remove.bind(this));
  },

  accept: function (event) {
    this.remove(event);
    this.action();
  },

  remove: function (event) {
    if (event) {
      event.stop();
    }
    this.element.remove();
  }
});

BILEXICON.Invitation.invitations = [];
BILEXICON.Invitation.removeAll = function () {
  BILEXICON.Invitation.invitations.each(Element.remove);
  BILEXICON.Invitation.invitations = [];
};

BILEXICON.Invitation.add = function (invitation) {
  BILEXICON.Invitation.invitations.push(invitation);
};

