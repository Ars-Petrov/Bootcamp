*** Settings ***
Library  Collections
*** Variables ***
@{tC}    ${0}  ${350}  ${-32}  ${100}
${transfer}
*** Test Cases ***
Сonversion of degrees to T(f)
    ${tF}    Сonversion to tF    @{tC}
    Log    ${tF}

*** Keywords ***
Сonversion to tF
    [Arguments]   @{tC}
    [Documentation]    This Keyword converts the temperature from celsius to fahrenheit
    @{tF}    Create List
    FOR    ${elements}   IN    @{tC}
       ${transfer}     Evaluate    ${9}/${5}*${elements}+${32}
       Append to list  ${tF}   ${transfer}
    END
    [Return]      ${tF}