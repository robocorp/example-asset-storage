*** Settings ***
Documentation    Store data in Control Room with Asset Storage

Library    RPA.JSON
Library    RPA.Robocorp.Storage
Library    String


*** Variables ***
${NAME}    robocorp-awesome
${TEXT}    Robocorp is awesome


*** Keywords ***
Ensure Text Asset
    Set Text Asset    ${NAME}    ${TEXT}

Cleanup Assets
    @{assets} =    List Assets
    FOR    ${asset}    IN    @{assets}
        ${ok} =    Run Keyword And Return Status
        ...    Should Start With    ${asset}    robocorp
        IF    ${ok}
            Log To Console    Removing asset: ${asset}
            Delete Asset    ${asset}
        END
    END

Store JSON
    [Documentation]    Setting a JSON dictionary in a new asset.
    [Arguments]    ${text}

    &{value} =    Create Dictionary    text    ${text}
    ${json_name} =    Set Variable    ${NAME}-json
    Set JSON Asset    ${json_name}    ${value}

    RETURN    ${json_name}

Store File
    [Documentation]    Setting a file asset with the previously set JSON content.
    [Arguments]    ${json_name}

    &{value} =    Get JSON Asset    ${json_name}
    ${path} =    Set Variable    ${OUTPUT_DIR}${/}${NAME}.json
    Save JSON To File    ${value}    ${path}
    ${file_name} =    Set Variable    ${NAME}-file
    Set File Asset    ${file_name}    ${path}

    ${path} =    Get File Asset    ${file_name}    ${path}    overwrite=${True}
    RETURN    ${path}


*** Tasks ***
Manage Assets
    [Setup]    Ensure Text Asset

    ${text} =    Get Text Asset    ${NAME}
    ${json_name} =    Store JSON    ${text}
    ${path} =    Store File    ${json_name}
    Log To Console    Retrieved file asset: ${path}

    [Teardown]    Cleanup Assets
