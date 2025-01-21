;; A test script

(define (string-replace strIn strReplace strReplaceWith)
    (let*
        (
            (curIndex 0)
            (replaceLen (string-length strReplace))
            (replaceWithLen (string-length strReplaceWith))
            (inLen (string-length strIn))
            (result strIn)
        )
        ;loop through the main string searching for the substring
        (while (<= (+ curIndex replaceLen) inLen)
            ;check to see if the substring is a match
            (if (substring-equal? strReplace result curIndex (+ curIndex replaceLen))
                (begin
                    ;create the result string
                    (set! result (string-append (substring result 0 curIndex) strReplaceWith (substring result (+ curIndex replaceLen) inLen)))
                    ;now set the current index to the end of the replacement. it will get incremented below so take 1 away so we don't miss anything
                    (set! curIndex (-(+ curIndex replaceWithLen) 1))
                    ;set new length for inLen so we can accurately grab what we need
                    (set! inLen (string-length result))
                )
            )
            (set! curIndex (+ curIndex 1))
        )
       (string-append result "")
    )
)

(define (script-fu-text-box inDir inWidth inHeight inSuffix)
    (gimp-message "This is a log message")
    (gimp-message "The directory is")
    (gimp-message inDir)    ;; You can easily print the directory name 
    (gimp-message inSuffix)

    (let* ((mInDir (string-replace inDir "\\" "\\\\"))
            (mInDir2 (string-append mInDir "\\\\*." inSuffix))
            (filelist (file-glob "d:\\\\project\\prjs\\pics\\*.png" 1))
            (fileNum (car filelist)))
        
        (gimp-message "The modified directory is")
        (gimp-message mInDir)
        (gimp-message "The 2nd modified directory is")
        (gimp-message mInDir2)
        (gimp-message "The file list num is")
        (gimp-message (number->string fileNum))
        ;; ('This is displayed as a message')
    
    )

    ;; loop the directory, print every picture name
    ;; (let* ( (mInDir (string-replace inDir "\\" "9"))
    ;         (filelist (cadr (file-glob mInDir 1)))
    ;         (file (car filelist))
    ;     )
        
    ;     (gimp-message "The file list is")
    ;     (gimp-message filelist)
    ;     (gimp-message "The file is")
    ;     (gimp-message file)

        ;(while file
        ;    (gimp-message file)
        ;    (set! file (car (cdr filelist)))
        ;)
    ;;)
)

  (script-fu-register
    "script-fu-text-box"                        ;function name
    "resize pics"                                  ;menu label
    "Creates a simple text box, sized to fit\
      around the user's choice of text,\
      font, font size, and color."              ;description
    "Michael Terry"                             ;author
    "copyright 1997, Michael Terry;\
      2009, the GIMP Documentation Team"        ;copyright notice
    "October 27, 1997"                          ;date created
    ""                                      ;image type that the script works on
    SF-DIRNAME     "Directory"      ""          ;a directory variable
    ;; SF-STRING      "Text"          "Text Box"   ;a string variable
    ; SF-FONT        "Font"          "Charter"    ;a font variable
    SF-ADJUSTMENT  "Width"     '(50 1 1000 1 10 0 1)
    SF-ADJUSTMENT  "Height"     '(50 1 1000 1 10 0 1)                                                ;a spin-button
    ;;SF-COLOR       "Color"         '(0 0 0)     ;color variable
    SF-STRING     "suffix"    "png"          ;a filename string
  )
  (script-fu-menu-register "script-fu-text-box" "<Image>/File/Create/custom")


