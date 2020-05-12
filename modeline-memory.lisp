(in-package :stumpwm)

(defun fmt-mem ()
  "Returns a string representing the current allocated memory."
  (with-open-file (file #P"/proc/meminfo" :if-does-not-exist nil)
    (let* ((mem-total (read-from-string (get-proc-file-field file "MemTotal")))
           (mem-free (read-from-string (get-proc-file-field file "MemFree")))
           (buffers (read-from-string (get-proc-file-field file "Buffers")))
           (cached (read-from-string (get-proc-file-field file "Cached")))
           (used-mem (/ (- mem-total mem-free buffers cached) 1024))
           (% (truncate (* 102400 (/ used-mem mem-total)))))
      (format nil "~7,2F ~a ^[~A~3D%^]"
              (if (> used-mem 1024)
                  (/ used-mem 1024) used-mem)
              (if (> used-mem 1024) "GB" "MB")
              (bar-zone-color %) %))))

(defvar *mem-formatters-alist*
  '((#\a fmt-mem)))

(defvar *mem-modeline-fmt* "MEM: %a")

(defun mem-modeline (ml)
  (declare (ignore ml))
  (format-expand *mem-formatters-alist*
                 *mem-modeline-fmt*))

(add-screen-mode-line-formatter #\M 'mem-modeline)
