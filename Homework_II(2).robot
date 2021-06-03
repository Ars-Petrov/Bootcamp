*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB
Library         JsonValidator

*** Variables ***
${insert_SQL}            INSERT INTO bootcamp.categories (category, categoryname) values (%(category)s, %(name)s) returning category
${select_SQL}            SELECT category FROM bootcamp.categories
${count_SQL}             SELECT COUNT(category) FROM bootcamp.categories
${remove_SQL}            DELETE FROM bootcamp.categories where category=17 returning ''
*** Test Cases ***

Table change request
  [Documentation]  Checking changes in table "categories"
  ${insertion_params}  Create dictionary  category=17  name=Test

  ${selection_params}  Create dictionary  category=17

  @{count}    DB.Execute Sql String    ${count_SQL}

  ${sum_params}   Create dictionary  category=17  name=Test
  ${sum_SQL}      Set variable  ${insert_SQL}; ${select_SQL}
  @{sum_result}   DB.Execute Sql String Mapped  ${sum_SQL}  &{sum_params}
  ${len_result}=  Get length  ${sum_result}

  ${cor_count}    Set variable  @{count}[0]
  ${cor_count} =  Evaluate  ${cor_count} + ${1}
  Should be equal as integers  ${cor_count}  ${len_result}
  Log many    @{sum_result}
  Test Cleaning

*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432

Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql

Test Cleaning
    ${remove_params}    Create dictionary  category=17
    @{remove_result}    DB.Execute Sql String    ${remove_SQL}  &{remove_params}
