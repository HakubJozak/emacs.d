(defun pivotal-insert-fix ()
  (interactive)

  (let ((BUFFER "*pivotal*")
        (stories ())
        (selected "")
        )

    (call-process "pt-fix" nil BUFFER)
    (setq count 0)

    (with-current-buffer BUFFER
      (beginning-of-buffer)

      (while (not (eobp))
        (setq count (+ count 1))
        (setq stories (cons
            (buffer-substring-no-properties (line-beginning-position) (line-end-position))
                         stories))
          (forward-line)
       ))

      (message "%s" stories)
      (message "%s" count)
      (insert (completing-read "Story: " stories))
     )
  )
