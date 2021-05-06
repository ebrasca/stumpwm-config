(in-package :stumpwm)

(defparameter *web-browser* "firefox")

;; (notify:notify-server-toggle)

(setf *startup-message* (machine-instance)
      *mouse-focus-policy* :ignore
      *mode-line-timeout* 5
      *group-format* " %n%s%t "
      *screen-mode-line-format* (list '(:eval (run-shell-command "date '+%F %H:%M'| tr -d [:cntrl:]" t))
                                      " | %C | %M | %l | [^B%n^b] %W"))

;; Turn on the modeline
(unless (head-mode-line (current-head))
  (toggle-mode-line (current-screen) (current-head)))

(run-commands "grename F1" "gnewbg F2" "gnewbg F3" "gnewbg F4" "gnewbg Next")
(run-commands "gselect 1")
