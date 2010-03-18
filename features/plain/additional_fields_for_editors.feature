Feature: word class dependent fields of lemmata
  To enable learners to learn well-formed grammar
  As an editor
  I want to add additional fields to lemmata

  Scenario: show word class dependent tags of nouns
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to noun
    Then I should see fields with type:
    | type          | field              |
    | radio buttons | gender             |
    | text fields   | singular genitive  |
    | text fields   | plural             |
    | check boxes   | singular only      |
    | check boxes   | collective         |
    | text fields   | female form        |
    | check boxes   | countable          |
    | check boxes   | uncountable        |

  Scenario: show word class dependent tags of verbs
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to verb
    Then I should see fields with type:
    | type          | field              |
    | check boxes   | auxiliary          |
    | text fields   | present tense      |
    | text fields   | past tense         |
    | text fields   | present participle |
    | text fields   | past participle    |
    | check boxes   | reflexive          |
    | check boxes   | regular            |
    | check boxes   | irregular          |
    | check boxes   | transitive         |
    | check boxes   | intransitive       |

  Scenario: show word class dependent tags of adjectives
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to adjective
    Then I should see fields with type:
    | type          | field              |
    | text fields   | comparative        |
    | text fields   | superlative        |
    | check boxes   | predicative        |
    | check boxes   | attributive        |

  Scenario: German only, additional fields are shown
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to verb
    Then I should see check boxes on the German half for:
      | field             |
      | perfekt haben     |
      | perfekt sein      |
      | partikel trennbar |
#      | hat ge            |
