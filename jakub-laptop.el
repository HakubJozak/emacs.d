;; (load-theme 'tango-dark)


;; (let ((class '((class color) (min-colors 89))))
;;   (custom-theme-set-faces
;;    'tango-dark
;;    ;; Highlighting faces
;;    `(highlight ((,class (:foreground unspecified :background "#222")))))
;;   )

;; (set-frame-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-17-*-*-*-m-0-iso10646-1")


(load-theme 'dichromacy)

(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'dichromacy
   ;; Highlighting faces
   `(highlight ((,class (:foreground unspecified :background "#e5e5e5")))))
  )

(setq my-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1")
(setq my-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-22-*-*-*-m-0-iso10646-1")

(set-default-font my-font)
(add-to-list 'default-frame-alist
             (cons 'font my-font))
