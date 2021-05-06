(in-package :stumpwm)

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

(defun cat (&rest strings)
  "Concatenates strings, like the Unix command 'cat'.
   A shortcut for (concatenate 'string foo bar)."
  (apply 'concatenate 'string strings))

(defmacro ret (var val &body body)
  "It is a blend of let and return"
  `(let ((,var ,val))
     ,@body
     ,var))

(defmacro make-web-jump (name prefix)
  `(defcommand ,name (search) ((:string ,(cat "Search in " (symbol-name name) " for: ")))
     ,(cat "Search in " (symbol-name name) " for: X")
     (check-type search string)
     (run-shell-command (cat "exec " *web-browser* " --new-tab '" ,prefix search "'"))))
