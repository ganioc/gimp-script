;; A test script

;; import sleep function

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

    (let* ( (pattern (string-append inDir "/*." inSuffix))
            (filelist (file-glob pattern 1))
            (fileNum (car filelist))
        )
        (gimp-message "The pattern is")
        (gimp-message pattern)
        (gimp-message "The file list is")
        (gimp-message (number->string fileNum))

        (if (> fileNum 0)
            (begin
                (let* ((mlist (cadr filelist))
                        (file (car mlist))
                    )
                    (while file 
                    
                        (gimp-message file)
                        ;; resize the picture
                        (let* ( 
                                (img (car (gimp-file-load RUN-NONINTERACTIVE file "")))
                                (drawable (car (gimp-image-active-drawable img)))
                                (width  inWidth)
                                (height  inHeight)
                                (outFile (string-append file ".resized." inSuffix))
                            )
                            (gimp-message (number->string width))
                            (gimp-message (number->string height))
                            (gimp-image-scale img width height)
                            (gimp-file-save RUN-NONINTERACTIVE img drawable outFile "")
                            ; (gimp-image-delete img)
                        )
                        ;(sleep 1000)
                        (set! mlist (cdr mlist))
                        (if (null? mlist)
                            (set! file #f)
                            (set! file (car mlist))
                        )
                        (gimp-message "done")
                        ;(set! file (car mlist))
                    )

                    ; (while file
                    ;     (gimp-message file)
                    ;     (set! file (car (cdr file)))
                    ; )
                )
            )
        )

    )
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
    SF-ADJUSTMENT  "Width"     '(512 1 2000 1 10 0 1)
    SF-ADJUSTMENT  "Height"     '(650 1 2000 1 10 0 1)                                                ;a spin-button
    ;;SF-COLOR       "Color"         '(0 0 0)     ;color variable
    SF-STRING     "suffix"    "png"          ;a filename string
  )
  (script-fu-menu-register "script-fu-text-box" "<Image>/File/Create/custom")


