*** Settings ***
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.HTTP
Library    RPA.Excel.Files
Library    RPA.RobotLogListener
Library    RPA.PDF
Resource    tasks.robot

*** Test Cases ***
Insert datafrom excelfile
    open the browser
    login
    open excel and load data
    Collect the result
    Export table as pdf
    Log out and Close browser



*** Keywords ***
open the browser
    Open Available Browser      https://robotsparebinindustries.com/
    Maximize Browser Window

login   
    Input Text     name:username    maria
    Input Password    name:password    thoushallnotpass
    Click Button    xpath://button[@type='submit']
    Wait Until Page Contains Element    id:sales-form

open excel and load data
    Open Workbook    SalesData.xlsx
    ${sales_rows}    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${sales_row}    IN    @{sales_rows}
        fill and submit form for one row    ${sales_row}
    END

fill and submit form for one row
    [Arguments]    ${sales_row}
    Input Text    name:firstname    ${sales_row}[First Name]
    Input Text    name:lastname    ${sales_row}[Last Name]
    Input Text    name:salesresult    ${sales_row}[Sales]
    Select From List By Value    salestarget    ${sales_row}[Sales Target]
    Click Button    Submit

Collect the result
    Screenshot    css:div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png    

Export table as pdf
    Wait Until Element Is Visible    id:sales-results
    ${sales_result_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_result_html}    ${OUTPUT_DIR}${/}sales_result.pdf

Log out and Close browser
    Click Button    Log out
    Sleep    3
    Close Browser

