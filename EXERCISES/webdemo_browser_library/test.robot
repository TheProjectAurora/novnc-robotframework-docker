*** Settings ***
Library   Browser

*** Test Cases ***
Example Test
    Open Browser    url=https://playwright.dev    browser=firefox    headless=false  
    Get Text    h1    contains    Playwright
    Close Browser