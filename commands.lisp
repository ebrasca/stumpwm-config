(in-package :stumpwm)

(defcommand emacs/normal () ()
  "Run or raise emacs/normal."
  (run-or-raise "emacs --name emacs/normal" '(:title "emacs/normal")))

(defcommand emacs/erc () ()
  "Run or raise emacs/erc."
  (run-or-raise "emacs --eval '(erc)' --name emacs/erc" '(:title "emacs/erc")))

(defcommand emacs/gnus () ()
  "Run or raise emacs/gnus."
  (run-or-raise "emacs --eval '(gnus)' --name emacs/gnus" '(:title "emacs/gnus")))

(defcommand firefox () ()
  "Start or switch to web-browser."
  (run-or-raise *web-browser* '(:instance "Navigator" :role "browser")))

(defcommand vlc () ()
  "Start or switch to vlc in f4 group."
  (run-commands "gselect 4")
  (run-or-raise "vlc" '(:class "vlc")))

(defcommand xterminal () ()
  "Start or raise xterminal."
  (run-or-raise "lxterminal" '(:class "Lxterminal")))

(defcommand exit (y-n) ((:y-or-n "Exit stumpwm?"))
  "Exit stumpwm"
  (when y-n
    (cl-user::exit)))

(make-web-jump wikipedia "http://www.wikipedia.org/wiki/")
(make-web-jump youtube "https://www.youtube.com/results?search_query=")
(make-web-jump cliki "http://cliki.net/site/search?query=")

(let ((server-running nil))
  (defcommand swank () ()
    "Toggle the swank server on/off"
    (cond (server-running
           (swank:stop-server 4006)
           (echo-string (current-screen) "Stopping swank.")
           (setf server-running nil))
          (t
           (swank:create-server :port 4006
                                :style swank:*communication-style*
                                :dont-close t)
           (echo-string (current-screen) "Starting swank.")
           (setf server-running t)))))

;; these commands are mainly intended to be called by external
;; commands through the use of stumpish
(defcommand stumpwm-input (prompt) ((:string "prompt: "))
  "prompts the user for one line of input."
  (read-one-line (current-screen) prompt))

(defcommand stumpwm-password (prompt) ((:string "prompt: "))
  "prompts the user for a password."
  (read-one-line (current-screen) prompt :password t))
