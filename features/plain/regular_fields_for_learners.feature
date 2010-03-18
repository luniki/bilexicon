Feature: regular fields of lemmata
  In order to learn well-formed grammar
  As a learner
  I want to see the attributes of lemmata

  @authenticated
  Scenario: regular fields are shown
    Given there is a noun
    And the noun has an annotation
    When I visit the lemma's page
    Then the page should show the annotation

