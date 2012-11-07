(setq last-kbd-macro
      [?\C-s ?\" ?\C-m ?\C-  ?\C-s ?\" ?\C-b ?\C-w ?c ?m ?s ?- ?\C-u f3 ?\C-a ?\C-n ?\C-s ?\" ?\C-  ?\C-s ?\" ?\C-b ?\C-w ?c ?m ?s ?- f3 ?\C-e])


(defun 3scale-feature-goto-fail ()
  (interactive)
  (let ((file (replace-regexp-in-string
	       "/home/jakub/prog/3scale/system/features/"
	       "/home/jakub/prog/3scale/system/tmp/capybara/features/"
	       (buffer-file-name))))
        (find-file file)))
