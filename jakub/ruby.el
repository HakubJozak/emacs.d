(defun find-gem (gem)
  "Open a directory with the gem via Bundler."
  (interactive "sGem: ")
  (let* ((cmd (concat "bundle show " gem " --no-color"))
         (result (shell-command-to-string-with-return-code cmd)))
    (if (= (car result) 0)
	(find-file (trim-string (cadr result)))
      (message (trim-string (cadr result))))))


(defun github-url-of-file (start end)
  "Pushes Github URL of current file and line into a kill ring."
  (interactive "r")
  (let* (
         (branch (magit-get-current-branch))
         (dir (find-git-repo (buffer-file-name)))
         (file (buffer-file-name))
         (url-root (concat "https://github.com/3scale/system/blob/" branch "/"))

         (line (if (region-active-p)
                   (concat (number-to-string (line-number-at-pos start)) "-" (number-to-string (line-number-at-pos end)))
                 (number-to-string (line-number-at-pos)
                                   )))

         (url (concat (replace-regexp-in-string dir url-root file) "#L" line))
         )
      (message url)
      (kill-new url)
    ))


; UTIL functions

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
  )

(defun shell-command-to-string-with-return-code (command)
  "Execute shell command COMMAND and return its output as a string."
  (let* ((return-code)
	 (result
          (with-output-to-string
            (with-current-buffer
                standard-output
              (setq return-code (call-process shell-file-name nil t nil shell-command-switch command))))))
    (list return-code result)))
