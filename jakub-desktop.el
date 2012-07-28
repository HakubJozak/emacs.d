(load-theme 'dichromacy)

(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'dichromacy
   ;; Highlighting faces
   `(highlight ((,class (:foreground unspecified :background "#e5e5e5")))))
  )

(add-to-list 'auto-mode-alist '("\.scss$" . css-mode))


(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
