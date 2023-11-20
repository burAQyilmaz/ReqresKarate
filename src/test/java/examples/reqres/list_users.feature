Feature: List Users Functionality

  Background: Url
    Given url "https://reqres.in/"

  Scenario: List all users
    Given path "api/users"
    And param page = 2
    When method get
    Then status 200
    And print response.data

  Scenario: Verify Content-Type
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * match karate.response.header("Content-Type") == "application/json; charset=utf-8"

  Scenario: Verify Connection
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * match karate.request.header("Connection") == "Keep-Alive"

  Scenario: Verify Host
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * match karate.request.header("Host") == "reqres.in"
    * match karate.request.headers.Host == "reqres.in"


  Scenario: Verify response time
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * print responseTime
    And assert responseTime<200


  Scenario: Verify page, per_page,total, total_pages
    Given path "api/users"
    And param page = 2
    When method get
    Then status 200
    * assert response.page == 2
    * assert response.per_page == 6
    * assert response.total == 12
    * assert response.total_pages == 2


  Scenario Outline: List all users
    Given path "api/users"
    And param page = "<pageNumber>"
    When method get
    Then status 200
    * print response.data
    Examples:
      | pageNumber |
      | 1          |
      | 2          |


  Scenario: Verify that support link is working
    Given path "api/users"
    And param page = 2
    When method get
    Then status 200
    * def supportUrl = response.support.url
    Given url supportUrl
    When method get
    Then status 200


  Scenario: List all user first names form first page
    Given path "api/users"
    And param page = 1
    When method get
    Then status 200
    * print response.data.map(i=>i.first_name)


  Scenario Outline: List all user names whose ids are odd
    Given path "api/users"
    And param page = "<pageNumber>"
    When method get
    Then status 200
    * def userList = response.data
    * def listOfIds =
    """
    function(list){

    var arr = []

    for (var i = 0; i < list.length; i++) {

        if(list[i].id % 2 == 1){
        arr.push(list[i])
        }
    }
    return arr;
    }
    """
    * print listOfIds(userList)
    Examples:
      | pageNumber |
      | 1          |
      | 2          |


  Scenario Outline:Check if each email address contains first name
    Given path "api/users"
    And param page = "<pageNumber>"
    When method get
    Then status 200
    * def userList = response.data
    * def check =
    """
    function(list){

    for (var i = 0; i < list.length; i++) {

        if(!list[i].email.toLowerCase().includes(list[i].first_name.toLowerCase())){
        return false;
        }
    }
    return true;
    }
    """
    * match check(userList) == true

    Examples:
      | pageNumber |
      | 1          |
      | 2          |


  Scenario Outline: Verify if the ids and first_names match
    Given path "api/users"
    And param page = "<pageNumber>"
    When method get
    Then status 200
    * match response.data.map(i=>i.id+ " " +i.first_name) contains "<id>"+" "+"<firstName>"

    Examples:
      | pageNumber | id | firstName |
      | 1          | 1  | George    |
      | 1          | 2  | Janet     |
      | 1          | 3  | Emma      |
      | 1          | 4  | Eve       |
      | 2          | 7  | Michael   |
      | 2          | 8  | Lindsay   |
      | 2          | 9  | Tobias    |
      | 2          | 10 | Byron     |



