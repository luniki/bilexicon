/* ------------------------------------------------------------------------
 * invitation
 * ------------------------------------------------------------------------ */
BILEXICON.Invitation = (function ($) {
    function Invitation(element, action) {
        this.element = element;
        this.action = action;

        _.bindAll(this, "addObservers", "accept", "remove");

        this.addObservers();
        Invitation.removeAll();
        Invitation.add(this);
    }

    Invitation.prototype.addObservers = function () {
        $(".accept", this.element).click(this.accept);
        $(".cancel", this.element).click(this.remove);
    };

    Invitation.prototype.accept = function (event) {
        this.remove(event);
        this.action();
    };

    Invitation.prototype.remove = function (event) {
        if (event) {
            event.preventDefault();
        }
        $(this.element).remove();
    };


    Invitation.invitations = [];

    Invitation.removeAll = function () {
        $(Invitation.invitations).remove();
        Invitation.invitations = [];
    };

    Invitation.add = function (invitation) {
        Invitation.invitations.push(invitation);
    };

    return Invitation;
})(jQuery);
