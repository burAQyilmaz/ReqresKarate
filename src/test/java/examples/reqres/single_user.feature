Feature: Single User Functionality

  Background: Url
    Given url "https://reqres.in/"
    * def allUsers = read("classpath:examples/reqres/data/users.json")

  Scenario: Verify id, email, first_name, last_name
    Given path "api/users"
    And path "2"
    When method get
    Then status 200
    * assert response.data.id == 2
    * assert response.data.email == "janet.weaver@reqres.in"
    * assert response.data.first_name == "Janet"
    * assert response.data.last_name == "Weaver"
    * print allUsers


  Scenario Outline: Check if persons with id is included in user list
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 200
    * match allUsers contains response.data

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |
      | 5  |
      | 6  |
      | 7  |
      | 8  |
      | 9  |
      | 10 |
      | 11 |
      | 12 |


  Scenario Outline: Verify if avatar is accessible
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 200
    * def avatar = response.data.avatar
    Given url avatar
    When method get
    Then status 200

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |
      | 5  |
      | 6  |
      | 7  |
      | 8  |
      | 9  |
      | 10 |
      | 11 |
      | 12 |

  Scenario Outline: Verify if avatar is accessible
    Given path "api/users"
    And path "<id>"
    When method get
    Then status 404
    * match response == {}

    Examples:
      | id  |
      | 100 |
      | 200 |
      | 300 |
