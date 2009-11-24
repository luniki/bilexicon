Feature: word class dependent fields of lemmata
  To enable learners to learn well-formed grammar
  As an editor
  I want to add additional fields to lemmata

  Scenario: the additional fields of nouns are shown
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

  Scenario: the additional fields of verbs are shown
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

  Scenario: the additional fields of adjectives are shown
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to adjective
    Then I should see fields with type:
      | type          | field              |
      | text fields   | comparative        |
      | text fields   | superlative        |
      | check boxes   | predicative        |
      | check boxes   | attributive        |

  Scenario: the additional fields of verbs on the German half are shown
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to verb
    Then I should see check boxes on the German half for:
      | field             |
      | perfekt haben     |
      | perfekt sein      |
      | partikel trennbar |
    And I should see radio buttons on the German half for:
      | field             |
      | hat ge            |

