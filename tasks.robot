*** Settings ***
Documentation       Template robot main suite.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.HTTP
Library    RPA.Excel.Files

*** Tasks ***
Insert sales data for week and export it as pdf
    open internet Browser
    login
    fill and submit form
    Download Excel File


    Close Browser

*** Keywords ***
open internet Browser
    Open Available Browser    https://robotsparebinindustries.com/

login
    Input Text    name:username    maria 
    Input Password    name:password    thoushallnotpass
    Submit Form
    Wait Until Page Contains Element    id:sales-form

fill and submit form
    Input Text    name:firstname    Jhon
    Input Text    name:lastname    Doe
    Select From List By Value    salestarget    15000
    Input Text    name:salesresult    555
    Click Button    Submit

Download Excel File
    Download    https://robotsparebinindustries.com/SalesData.xlsx    overwrite=True