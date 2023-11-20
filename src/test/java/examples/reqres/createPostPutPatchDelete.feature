Feature: createPostPutPatchDelete.feature

  Background: Url
    Given url "https://reqres.in/"

  Scenario: Create a user with certain name and job and verify if it is created

    Given path "api/users"
    And request person = {"name" : "Burak", "job" : "QA"}
    When method post
    Then status 201
    * match response.name == person.name
    * match response.job == person.job


  Scenario Outline: Create multiple users with given data and verify if all of them are created
    Given path "api/users"
    And request person = {"name" : "<name>", "job" : "<job>"}
    When method post
    Then status 201
    * match response.name == person.name
    * match response.job == person.job

    Examples:
      | name | job       |
      | John | SDET      |
      | Ally | Developer |
      | Jack | Tester    |


  Scenario: Update one user and verify if it is updated (put)
    Given path "api/users"
    And path "35"
    And request person = {"name" : "Nalan", "job" : "Student"}
    When method put
    Then status 200
    And match response.name == person.name
    And match response.job == person.job


  Scenario Outline: Update users with following ids 134,135,136 (put)
    Given path "api/users"
    And path "<id>"
    And request person = {"name" : "<name>", "job" : "<job>"}
    When method put
    Then status 200
    And match response.name == person.name
    And match response.job == person.job

    Examples:
      | id  | name | job       |
      | 134 | Sam  | Tester    |
      | 135 | John | Developer |
      | 136 | Eden | QA        |


  Scenario: Update one user and verify if it is updated (patch)
    Given path "api/users"
    And path "45"
    And request person = {"name" : "Nilgun"}
    When method patch
    Then status 200
    And match response.name == person.name


  Scenario Outline: Update users with following ids 121,122,123 (patch)
    Given path "api/users"
    And path "<id>"
    And request person = {"job" : "<job>"}
    When method patch
    Then status 200
    And match response.job == person.job

    Examples:
      | id  | job       |
      | 121 | Tester    |
      | 122 | Developer |
      | 123 | QA        |


  Scenario: Delete one user and verify if it is deleted (delete)
    Given path "api/users"
    And path "25"
    When method delete
    Then status 204


  Scenario Outline: Delete users with following ids 121,122,123 (delete)
    Given path "api/users"
    And path "<id>"
    When method delete
    Then status 204

    Examples:
      | id  |
      | 121 |
      | 122 |
      | 123 |



