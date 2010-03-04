Feature: create decks of flashcards from categories
  In order to learn all lemmata of a category
  As a learner
  I want to create a new deck using these lemmata

@authenticated @wip
Scenario: a "create" button is shown authenticated learners
  Given a category named "Travel & Transport"
  When I go to the category "Travel & Transport"
  Then I should see a link to create a new deck

@authenticated @wip
Scenario: the "create" button should transport the learner to the "new deck" page
  Given a category named "Travel & Transport"
  When I go to the category "Travel & Transport"
  And I follow "create_deck"
  Then I should see a text field containing "Travel & Transport"

@authenticated @wip
Scenario: the "create" button should transport the learner to the "new deck" page
  Given a category named "Travel & Transport"
  When I create a new deck from the category "Travel & Transport"
  Then I should see a a new deck named "Travel & Transport"

