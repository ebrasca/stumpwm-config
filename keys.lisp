(in-package :stumpwm)

;;; clear keys
(undefine-key *root-map* (kbd "c"))
(undefine-key *root-map* (kbd "C-c"))
(undefine-key *root-map* (kbd "C-b"))
(undefine-key *root-map* (kbd "C-a"))
(undefine-key *root-map* (kbd "C-m"))

;;; *top-map*
(set-prefix-key (kbd "C-<"))

;;; *root-map*
(define-key *root-map* (kbd "x") '*app-map*)
(define-key *root-map* (kbd "i") '*internet-map*)

(define-key *root-map* (kbd "q") "exit")

(defparameter *internet-map*
  (ret m (stumpwm:make-sparse-keymap)
    (define-key m (kbd "w") "wikipedia")
    (define-key m (kbd "y") "youtube")
    (define-key m (kbd "c") "cliki")
    (define-key m (kbd "b") (format nil "colon1 exec ~a --new-tab http://www." *web-browser*))))

(defparameter *app-map*
  (ret m (stumpwm:make-sparse-keymap)
    (define-key m (kbd "e") "emacs/normal")
    (define-key m (kbd "i") "emacs/erc")
    (define-key m (kbd "m") "emacs/gnus")
    (define-key m (kbd "c") "xterminal")
    (define-key m (kbd "v") "vlc")
    (define-key m (kbd "q") "qtox")
    (define-key m (kbd "f") "firefox")
    (define-key m (kbd "s") "swank")))
