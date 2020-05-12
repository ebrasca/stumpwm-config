(in-package :stumpwm)

;; Load modules
(set-module-dir "~/common-lisp/WM/stumpwm-contrib/")
(ql:quickload '(;; :next
		:swank
                :trivial-shell
                :cl-ppcre
		:net
                ;; :notify
		))

(init-load-path *module-dir*)

(defun utl-load (filename)
  (let ((file (concat "~/.stumpwm.d/" filename ".lisp")))
    (if (probe-file file)
        (load file)
        (format *error-output* "File '~a' doesn't exist." file))))

(loop :for file :in '("utils"
                      "modeline-cpu"
                      "modeline-memory"
                      "config"
                      "keys"
                      "commands"
                      "private")
      :do (utl-load file))
