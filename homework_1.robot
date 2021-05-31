*** Settings ***
Library  Collections
*** Variables ***
@{list}    ${1}  ${2}  ${3}  ${5}  ${1}  ${0}  ${-1}  ${10}
${expected_min_value}     ${-1}
${expected_max_value}     ${10}
${theSum}                 ${0}
*** Test Cases ***
Find lowest and hights value
    [Documentation]   find min and max values in list and compare
    Sort List    ${list}
    ${min_value}    Get From List    ${list}     0
    ${max_value}    Get From List    ${list}     -1
    Should Be Equal    ${min_value}    ${expected_min_value}
    Should Be Equal    ${max_value}    ${expected_max_value}

Find uniqual values
    [Documentation]    List with unique values
       ${unique}    Create List
    FOR    ${element}   IN    @{list}
        ${count}    Count Values In List    ${list}    ${element}
        IF  ${count} == ${1}
            Append To List    ${unique}     ${element}
        END
    END
    log    ${unique}


Find list sum
    [Documentation]   find sum numbers in list

    FOR    ${elements}   IN    @{list}
        ${theSum}     Evaluate  ${theSum}+${elements}
    END
    Log    ${theSum}






