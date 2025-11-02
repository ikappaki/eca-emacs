;;; -*- lexical-binding: t; -*-
(require 'buttercup)
(require 'eca-diff)

(defconst native-eol
  (if (eq system-type 'windows-nt)
      "\r\n"
    "\n")
  "Native end-of-line string for the current operating system.")

                           ;; No EOL
(describe "can parse unified diffs"
  (it "with any native os eol endings"
    (let* ((ud-lines '("--- old.txt"
        "+++ new.txt"
        "@@ -1,3 +1,4 @@"
        "-Line 1"
        "-Line 2"
        "+Line 1 modified"
        "+Line 2"
        "+Line 3 added")))
      (expect (eca-diff-parse-unified-diff (string-join ud-lines native-eol))
              :to-equal
              `(:original ,(string-join '("Line 1" "Line 2") native-eol)
                :new      ,(string-join '("Line 1 modified" "Line 2" "Line 3 added") native-eol))))))
