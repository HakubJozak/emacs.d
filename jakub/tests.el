(defun my-tests-location (name)
  (let ((sanitized-name (sanitize-name name)))
   (ffap-locate-file  sanitized-name
		      '()
		      '( "/home/rgrau/workspace/sw/"))))
(defun sanitize-name (name)
  (replace-regexp-in-string "/var/lib/jenkins/jobs/[^/]*/workspace/"
         "" name))

(eval-after-load "ffap"
  '(add-to-list 'ffap-alist '(w3m-mode . my-tests-location)))

(eval-after-load "ffap"
  '(add-to-list 'ffap-alist '(erc-mode . my-tests-location)))


(defadvice find-file-at-point (around goto-line compile activate)
  (let ((line (and (looking-at ".*:\\([0-9]+\\)")
                   (string-to-number (match-string 1)))))
    ad-do-it
    (and line (goto-line line))))
