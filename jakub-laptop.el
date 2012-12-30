(load-theme 'tango-dark)


(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'tango-dark
   ;; Highlighting faces
   `(highlight ((,class (:foreground unspecified :background "#222")))))
  )



(set-frame-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1")
