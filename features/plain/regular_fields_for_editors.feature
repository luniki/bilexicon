Feature: editable regular fields
  To enable learners to learn well-formed grammar
  As an editor
  I want to add and edit regular fields of lemmata

  Scenario: the lemma's regular fields can be filled
    Given I am an editor
    And I am creating a new lemma
    Then I should see fields with type:
    | field      | type       |
    | annotation | text field |

