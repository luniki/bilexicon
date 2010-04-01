Feature: simple markup in fields
  In order to call the learners attention to certain words in a field
  As an editor
  I want to use simple markup

  @authenticated
  Scenario: show underlined words in lemma's short fields
    Given the following lemma exists:
    | short1               | short2               |
    | short1 _with_ markup | short2 _with_ markup |
    When I visit the lemma's page
    Then I should see underlined text in the header

  @authenticated
  Scenario: show underlined words in lemma's long fields
    Given the following lemma exists:
    | long1               | long2               |
    | long1 _with_ markup | long2 _with_ markup |
    When I visit the lemma's page
    Then I should see underlined text in field ".form1"
    And  I should see underlined text in field ".form2"

  @authenticated
  Scenario Outline: show underlined words in forms of subentries
    Given a lemma with the following <type> exists:
    | form1   | form2   |
    | form1 _with_ markup | form2 _with_ markup |
    When I visit the lemma's page
    Then I should see underlined text in field ".subentry .form1"
    And  I should see underlined text in field ".subentry .form2"

  Examples:
    | type           |
    | valencies      |
    | collocations   |
    | phraseologisms |

