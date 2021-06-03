*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Library         Collections         WITH NAME   Col
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB

*** Test Cases ***
Search data from tables
    ${resp}    GET On Session    alias    /products?    params=price=lt.10&category=eq.13&title=like.AIRPORT*
    ${qwerty}    Get From List     ${resp.json()}    0
    ${prod_id_serv}     create list
    ${price_serv}       create list
    FOR  ${i}  IN  @{resp.json()}
        ${prod_id_value}   Get From Dictionary   ${i}   prod_id
        ${price_value}   Get From Dictionary   ${i}   price
        Col.Append To List   ${prod_id_serv}      ${prod_id_value}
        Col.Append To List   ${price_serv}      ${price_value}
    END


    ${params}    create dictionary    category=13     title=AIRPORT\%    price=10
    ${SQL}       set variable         SELECT prod_id, price, title from bootcamp.products where category=%(category)s and title like %(title)s and price<%(price)s
    Log     ${SQL}
    @{result}    DB.Execute Sql String Mapped   ${SQL}   &{params}
    ${prod_id_db}      create list
    ${price_db}        create list
    FOR  ${k}  IN  @{result}
        ${k2}   convert to number  ${k}[price]
        Col.Append To List   ${prod_id_db}      ${k}[prod_id]
        Col.Append To List   ${price_db}        ${k2}
    END

    Col.Lists Should Be Equal   ${prod_id_serv}    ${prod_id_db}
    Col.Lists Should Be Equal   ${price_serv}      ${price_db}
*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432
Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql