*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432

Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql

Test Cleaning
    ${removing_params}  create dictionary  category=17

    @{remov_result}  DB.Execute Sql String  ${removing_SQL}  &{removing_params}
    Test Teardown

Different_in_Compare
    [Arguments]  ${Before}  ${After}  ${add_count}
    ${cor_count}    Set variable  @{count}[0]
  ${cor_count} =  Evaluate  ${cor_count} + ${1}
  Should be equal as integers  ${cor_count}  ${len_result}