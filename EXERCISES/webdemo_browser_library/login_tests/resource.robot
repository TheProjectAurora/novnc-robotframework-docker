*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Browser.
Library           Browser

*** Variables ***
${SERVER}         webdemo:7272
${BROWSER}        Firefox
${HEADLESS}       false
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Open Browser To Login Page
    Open Browser    url=${LOGIN URL}    browser=${BROWSER}    headless=${HEADLESS}
    #Maximize Browser Window
    #Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Get Title    assertion_operator=should be    assertion_expected=Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Fill Text    id=username_field    ${username}

Input Password
    [Arguments]    ${password}
    Fill Text    id=password_field    ${password}

Submit Credentials
    Click    id=login_button

Welcome Page Should Be Open
    Get Url    assertion_operator=should be    assertion_expected=${WELCOME URL}
    Get Title    assertion_operator=should be    assertion_expected=Welcome Page
