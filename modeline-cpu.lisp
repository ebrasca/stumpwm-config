(in-package :stumpwm)

(defun fmt-cpu-usage ()
  "Returns a string representing current the percent of average CPU
  utilization."
  (with-open-file (in #P"/proc/loadavg" :direction :input)
    (let ((cpu (truncate (* 100 (/ (read in) 8))))) ;; 8 threads
      (format nil "CPU: ^[~A~3D%^] " (bar-zone-color cpu) cpu))))

(defun fmt-cpu-freq ()
  "Returns a string representing the current CPU frequency (especially useful for laptop users.)"
  (let ((mhz (parse-integer (get-proc-file-field "/proc/cpuinfo" "cpu MHz")
                            :junk-allowed t)))
    (format nil "~,2FGHz" (/ mhz 1000))))

(defun fmt-cpu-temp ()
  "Returns a string representing the current CPU temperature."
  (with-open-file (in #P"/sys/class/thermal/thermal_zone2/temp" :direction :input)
    (format nil "~,2FC" (/ (read in) 1000))))

(defvar *cpu-formatters-alist*
  '((#\c fmt-cpu-usage)
    (#\f fmt-cpu-freq)
    ;; (#\t fmt-cpu-temp)
    ))

(defvar *cpu-modeline-fmt* "%c (%f) %t")

(defun cpu-modeline (ml)
  (declare (ignore ml))
  (format-expand *cpu-formatters-alist*
                 *cpu-modeline-fmt*))

;; Install formatters.
(add-screen-mode-line-formatter #\C 'cpu-modeline)
