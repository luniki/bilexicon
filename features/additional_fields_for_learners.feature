Feature: word class dependent fields of lemmata
  To learn well-formed grammar
  As a learner
  I want to see irregularities and attributes of lemmata

  Scenario Outline: show irregular, bilingual fields for nouns
    Given there is a noun
    And the noun has an irregular <field>
    When I visit the lemma's page
    Then the page should show the irregular <field>

  Examples:
    | field             |
    | singular genitive |
    | plural            |
    | female form       |

  Scenario Outline: show bilingual attributes for nouns
    Given there is a noun
    And the noun is a <attribute> noun
    When I visit the lemma's page
    Then the page should show the that the noun is a <attribute> noun

  Examples:
    | attribute     |
    | singular only |
    | collective    |
    | compound      |

  Scenario: show gender for nouns
    Given a female noun
    When I visit the lemma's page
    Then the page should say that the lemma is female


# VERBS


  Scenario Outline: show bilingual attributes for verbs
    Given there is a verb
    And the verb is a <attribute> verb
    When I visit the lemma's page
    Then the page should show the that the verb is a <attribute> verb

  Examples:
    | attribute    |
    | auxiliary    |
    | reflexive    |
    | regular      |
    | irregular    |
    | transitive   |
    | intransitive |

  Scenario Outline: show irregular, bilingual fields for verbs
    Given there is a verb
    And the verb has an irregular <field>
    When I visit the lemma's page
    Then the page should show the irregular <field>

  Examples:
    | field           |
    | present tense   |
    | past tense      |
    | past participle |

  Scenario: show type of perfect on german verbs
    Given there is a verb
    And the verb has a perfect with "haben"
    When I visit the lemma's page
    Then the page should say that the lemma has perfect with "haben"

  Scenario: show type of perfect on german verbs
    Given there is a verb
    And the verb has a perfect with "sein"
    When I visit the lemma's page
    Then the page should say that the lemma has perfect with "sein"

  Scenario: show Partikeltrennbarkeit on german verbs
    Given there is a verb
    And the verb's Partikel is trennbar
    When I visit the lemma's page
    Then the page should say that the lemma's Partikel is trennbar

  Scenario: show additional fields in a readable form
    Given there is a lemma with additional fields
    When I visit the lemma's page
    Then the page should show me the additional fields in a readable form
  Scenario: show -ge- on german verbs
    Given there is a verb
    And the verb has -ge-
    When I visit the lemma's page
    Then the page should say that the lemma has -ge-

# ADJECTIVES



  Scenario Outline: show bilingual attributes for adjectives
    Given there is a adjective
    And the adjective is a <attribute> adjective
    When I visit the lemma's page
    Then the page should show the that the adjective is a <attribute> adjective

  Examples:
    | attribute   |
    | predicative |
    | attributive |

  Scenario Outline: show irregular, bilingual fields for adjectives
    Given there is a adjective
    And the adjective has an irregular <field>
    When I visit the lemma's page
    Then the page should show the irregular <field>

  Examples:
    | field       |
    | comparative |
    | superlative |

