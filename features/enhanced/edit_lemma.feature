Feature: edit lemma while staying on the page
  To see the context of a lemma while editing
  As an editor
  I want to edit inline and stay on the page

  @wip
  Scenario: the level is changed
    Given I am an editor
    And a lemma of level "A1/A1" exists
    When I go to the lemma page
    And I start editing inline
    And I select "B1" from "lemma_level_rezeptiv"
    And I select "B2" from "lemma_level_produktiv"
    And I submit the inline edit form
    Then I should see "B1/B2"

