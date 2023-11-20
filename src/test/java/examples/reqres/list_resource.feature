Feature: List Resource Functionality

  Background: Url
    Given url "https://reqres.in/"

  Scenario: Verify page, per_page,total, total_pages
    Given path "api/unknown"
    When method get
    Then status 200
    * assert response.page == 1
    * assert response.per_page == 6
    * assert response.total == 12
    * assert response.total_pages == 2


  Scenario: List all data with 2000 and 2001 years
    Given path "api/unknown"
    When method get
    Then status 200
    * print response.data.filter(i=> i.year==2000 || i.year==2001)


  Scenario: Verify that all color codes starts with "#" and have 7(total) chars
    Given path "api/unknown"
    When method get
    Then status 200
    * def filtered = response.data.filter(i=>i.color.startsWith("#") && i.color.length == 7)
    * match  filtered == response.data
    * print filtered


  Scenario: Verify that all the value of pantone_values in following format "##-####"
    Given path "api/unknown"
    When method get
    Then status 200
    * def pantone_values_size = response.data.filter(i=>i.pantone_value.length == 7 && i.pantone_value.charAt(2) == "-").length
    #* def pantone_values_size = response.data.filter(i => i.pantone_value.matches("\\d{2}-\\d{4}")).length
    #* def pantone_values_size = response.data.filter(i => i.pantone_value.matches("[A-Za-z0-9]{2}-[A-Za-z0-9]{4}")).length
    * match pantone_values_size == response.data.length

  Scenario: Verify the year of second element of data is 2001
    Given path "api/unknown"
    When method get
    Then status 200
    * def year = response.data[1].year
    * assert year == 2001;

  Scenario: Verify the value of text in support is "To keep ReqRes free, contributions towards server costs are appreciated!"
    Given path "api/unknown"
    When method get
    Then status 200
    * def supportText = response.support.text
    * assert supportText == "To keep ReqRes free, contributions towards server costs are appreciated!"

  Scenario: Verify that each element of response is not null
    Given path "api/unknown"
    When method get
    Then status 200
    * match each response.data != null

