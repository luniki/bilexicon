Feature: word class dependent fields of lemmata
  To enable learners to learn well-formed grammar
  As an editor
  I want to add additional fields to lemmata

  @no-txn
  Scenario Outline: show word class dependent tags
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to <word_class>
    Then I should see <type> for <field>

  Examples:
    | word_class | type          | field              |
    | noun       | radio buttons | gender             |
    | noun       | text fields   | singular genitive  |
    | noun       | text fields   | plural             |
    | noun       | check boxes   | singular only      |
    | noun       | check boxes   | collective         |
    | noun       | check boxes   | compound           |
    | noun       | text fields   | female form        |
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
    | adjective  | text fields   | comparative        |
    | adjective  | text fields   | superlative        |
    | adjective  | check boxes   | predicative        |
    | adjective  | check boxes   | attributive        |

  @no-txn
  Scenario Outline: TODO
    Given I am an editor
    And I am creating a new lemma
    When I set the word class to verb
    Then I should see a checkbox for <field> on the German half

  Examples:
    | field             |
    | perfekt haben     |
    | perfekt sein      |
    | partikel trennbar |
    | hat ge            |
