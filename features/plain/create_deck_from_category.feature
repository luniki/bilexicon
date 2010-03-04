Feature: create decks of flashcards from categories
  In order to learn all lemmata of a category
  As a learner
  I want to create a new deck using these lemmata

@authenticated @wip
Scenario: a "create" button is shown authenticated learners
  Given a category named "Travel & Transport"
  When I go to the category "Travel & Transport"
  Then I should see a button to create a new deck

