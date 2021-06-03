
*** Settings ***
Documentation   tests to check for adding data in a table and searching data in 2 tables
Metadata        Author       Petrov Arseniy

Test Timeout  10s

Test Setup      Test Setup
Test Teardown   Test Teardown
Resource        Keywords.robot
Resource        resource.robot
Resource        Variables.robot
*** Test Cases ***
Search data in tables
  [Documentation]  search data in 2 tables with SQL request
  ${params}    create dictionary    amount=10000
  ${python_result}=  TW.mult_table  ${params}[amount]
  ${python_count}=  get length  ${python_result}

  should be equal as integers  ${python_count}  ${select_rows_count_SQL}

Change Table request
  [Documentation]  tests to check for adding data in a table
  ${insertion_params}  create dictionary  category=17  name=Test
  ${Before} =  TW.table_count
  ${python_result}=  TW.insert_sql  ${insertion_params}[category]  ${insertion_params}[name]
  ${After} =  TW.table_count
  Different_in_Compare         ${Before}   ${After}  ${1}


