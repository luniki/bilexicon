Feature: Searching for lemmata
  To help students learn better English
  they should be able to search for lemmata

  Scenario: browsing the home page
    Given there is at least one lemma
    When I go to the home page
    Then I should see a search form
