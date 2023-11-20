
Feature: delayedResponse.feature

  Background: Url
    Given url "https://reqres.in/"

  Scenario: Delay response for 2 seconds and verify that response time is bigger then delay time
    Given path "/api/users"
    * def delayTime = 3
    And param delay = delayTime
    When method get
    Then status 200
    * assert responseTime > delayTime*1000

  Scenario Outline: Delay response for 2,3,4,5 seconds for each time and verify that response times are bigger then delay times
    Given path "/api/users"
    * def delayTime = "<time>"
    And param delay = delayTime
    When method get
    Then status 200
    * assert responseTime > delayTime*1000

    Examples:
      | time |
      | 2    |
      | 3    |
      | 4    |
      | 5    |