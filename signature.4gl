IMPORT util

MAIN
DEFINE signature STRING 
DEFINE mode STRING
DEFINE result STRING

    OPEN WINDOW signature WITH FORM "signature"

    LET mode = "sign"
    WHILE mode != "exit"
        CASE mode
            WHEN "sign"
                INPUT BY NAME signature WITHOUT DEFAULTS ATTRIBUTES(UNBUFFERED)
                    ON ACTION clear
                        -- clears the web component
                        CALL ui.Interface.frontCall("webcomponent","call",["formonly.signature","signaturePadClear"],[result])
                    ON ACTION save
                        -- saves the web component to file signature.png
                        CALL ui.Interface.frontCall("webcomponent","call",["formonly.signature","signaturePadSave"],[result])
                        CALL util.Strings.base64Decode(result.subString(23,result.getLength()),"signature.png")
                    ON ACTION empty
                        -- Test if web component is empty
                        CALL ui.Interface.frontCall("webcomponent","call",["formonly.signature","signaturePadEmpty"],[result])
                        DISPLAY result
                    ON ACTION view
                        LET mode = "view"
                        EXIT INPUT
                    ON ACTION close
                        LET mode = "exit"
                        EXIT INPUT
                END INPUT
                
            WHEN "view"
                -- will dispay last saved web component
                DISPLAY "signature.png" TO img
                MENU ""
                    ON ACTION sign
                        LET mode = "sign"
                        EXIT MENU
                    ON ACTION close
                        LET mode = "exit"
                        EXIT MENU
                END MENU
        END CASE
    END WHILE
    CLOSE WINDOW signature
END MAIN


