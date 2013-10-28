(setq magit-set-upstream-on-push 'dontask)

(defun stash-and-checkout ()
  (interactive)
  (magit-stash "")
  (call-interactively 'magit-checkout)
  (message "Branch switched")
  )

(define-key global-map (kbd "C-c b") 'stash-and-checkout)

(defun github-url-of-file (start end)
  "Pushes Github URL of current file and line into a kill ring."
  (interactive "r")
  (let* (
         (branch (magit-get-current-branch))
         (dir (find-git-repo (buffer-file-name)))
         (file (buffer-file-name))
         (project (ido-completing-read "Project: " '("system" "backend" "stuff")))
         (url-root (format "https://github.com/3scale/%s/blob/%s/" project branch))

         (line (if (region-active-p)
                   (concat (number-to-string (line-number-at-pos start)) "-" (number-to-string (line-number-at-pos end)))
                 (number-to-string (line-number-at-pos)
                                   )))

         (url (concat (replace-regexp-in-string dir url-root file) "#L" line))
         )
      (message url)
      (kill-new url)
    ))


; (replace-regexp-in-string "/home/jakub/.rvm/gems/ruby-1.9.3-p286@rails3/gems/activesupport-3.2.12/lib/active_support/dependencies/" url-root file)


(setq magit-default-tracking-name-function 'magit-default-tracking-name-branch-only)


(defun sm-try-smerge ()
   (save-excursion
     (goto-char (point-min))
     (when (re-search-forward "^<<<<<<< " nil t)
       (smerge-mode 1))))

(add-hook 'find-file-hook 'sm-try-smerge t)
