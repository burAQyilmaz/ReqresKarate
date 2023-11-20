

Feature: registerLogin.feature

  Background: Url
    Given url "https://reqres.in/"


  Scenario: Register a user with given email and password and verify if token is not null
    Given path "api/register"
    And request person = {"email" : "eve.holt@reqres.in", "password" : "pistol"}
    When method post
    Then status 200
    * assert response.token != null


  Scenario Outline: Register 4 different users with given emails and passwords and verify if tokens are not null
    Given path "api/register"
    And request person = {"email" : "<email>", "password" : "<password>"}
    When method post
    Then status 200
    * assert response.token != null

    Examples:
      | email                      | password |
      | michael.lawson@reqres.in   | secret   |
      | lindsay.ferguson@reqres.in | secret   |
      | tobias.funke@reqres.in     | secret   |
      | byron.fields@reqres.in     | secret   |


  Scenario: Try to register a user with a given email and verify if error message is "Missing password"
    Given path "api/register"
    And request person = {"email" : "sydney@fife"}
    When method post
    Then status 400
    * assert response.error == "Missing password"


  Scenario Outline: Try to register 4 different users with given emails and verify that  error message is "Missing password" for each of them
    Given path "api/register"
    And request person = {"email" : "<email>"}
    When method post
    Then status 400
    * assert response.error == "Missing password"

    Examples:
      | email                      |
      | michael.lawson@reqres.in   |
      | lindsay.ferguson@reqres.in |
      | tobias.funke@reqres.in     |
      | byron.fields@reqres.in     |

  Scenario: Login a valid email and password and verify if token is not null
    Given path "api/login"
    And request person = {"email" : "eve.holt@reqres.in" , "password" : "cityslicka"}
    When method post
    Then status 200
    * assert response.token != null


  Scenario Outline: Login 4 different users with valid emails and passwords and verify if tokens are not null
    Given path "api/login"
    And request person = {"email" : "<email>", "password" : "<password>"}
    When method post
    Then status 200
    * assert response.token != null

    Examples:
      | email                      | password |
      | michael.lawson@reqres.in   | secret   |
      | lindsay.ferguson@reqres.in | secret   |
      | tobias.funke@reqres.in     | secret   |


  Scenario: Try to login with an email and verify if error message is "Missing password"
    Given path "api/login"
    And request person = {"email" : "peter@klaven"}
    When method post
    Then status 400
    * assert response.error == "Missing password"


  Scenario Outline: Try to login as 4 different users with given emails and verify that  error message is "Missing password" for each of them    Given path "api/register"
    Given path "api/login"
    And request person = {"email" : "<email>"}
    When method post
    Then status 400
    * assert response.error == "Missing password"

    Examples:
      | email                      |
      | michael.lawson@reqres.in   |
      | lindsay.ferguson@reqres.in |
      | tobias.funke@reqres.in     |
      | byron.fields@reqres.in     |
