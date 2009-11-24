Feature: word class dependent fields of lemmata
  To enable learners to learn well-formed grammar
  As an editor
  I want to add additional fields to lemmata

  Scenario: show word class dependent tags of nouns
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to noun
    Then I should see fields with type:
    | word_class | type          | field              |
    | noun       | radio buttons | gender             |
    | noun       | text fields   | singular genitive  |
    | noun       | text fields   | plural             |
    | noun       | check boxes   | singular only      |
    | noun       | check boxes   | collective         |
    | noun       | text fields   | female form        |

  Scenario: show word class dependent tags of verbs
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to verb
    Then I should see fields with type:
    | word_class | type          | field              |
    | verb       | check boxes   | auxiliary          |
    | verb       | text fields   | present tense      |
    | verb       | text fields   | past tense         |
    | verb       | text fields   | present participle |
    | verb       | text fields   | past participle    |
    | verb       | check boxes   | reflexive          |
    | verb       | check boxes   | regular            |
    | verb       | check boxes   | irregular          |
    | verb       | check boxes   | transitive         |
    | verb       | check boxes   | intransitive       |

  Scenario: show word class dependent tags of adjectives
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to adjective
    Then I should see fields with type:
    | word_class | type          | field              |
    | adjective  | text fields   | comparative        |
    | adjective  | text fields   | superlative        |
    | adjective  | check boxes   | predicative        |
    | adjective  | check boxes   | attributive        |

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
