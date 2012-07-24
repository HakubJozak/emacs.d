; Miscelaneous setq'
(setq require-final-newline nil)
(setq truncate-lines nil)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")


(remove-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


; IDo
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
(setq ido-default-file-method "selected-window"
      ido-default-buffer-method "selected-window")

; Windows & Buffers
;
(winner-mode)
(require 'buffer-move)

; http://stackoverflow.com/questions/1774832/how-to-swap-the-buffers-in-2-windows-emacs
(defun window-swap () "Swap windows using buffer-move.el"
  (interactive)
  (if (null (windmove-find-other-window 'right))
      (buf-move-left) (buf-move-right))
  (other-window 1)
  )

(global-set-key (kbd "C-c s") 'window-swap)


; Keys
(global-set-key (kbd "C-x f") 'find-file-in-git-repo)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c [") 'winner-undo)
(global-set-key (kbd "C-c ]") 'winner-redo)
(global-set-key (kbd "C-c g") 'vc-git-grep)
(global-set-key (kbd "C-c C-c [") 'multi-term-prev)
(global-set-key (kbd "C-c C-c ]") 'multi-term-next)

(global-set-key [f10] (lambda () (interactive) (open-utility-file  "~/.emacs.d/jakub/snippets/text-mode/ruby-mode/")))
(global-set-key [f11] (lambda () (interactive) (open-utility-file  "~/.emacs.d/jakub.el")))
(global-set-key [f12] (lambda () (interactive) (open-utility-file  "~/.bashrc")))
(global-set-key (kbd "C-c C-x C-f") 'sudo-edit)


(add-hook 'coding-hook (lambda ()
  (local-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
  (local-set-key (kbd "C-c f") 'er/expand-region)
  (local-set-key (kbd "C-c b") 'er/contract-region)))



(defun jakub/set-compilation-text-scale ()
  (text-scale-adjust -1)
  (setq truncate-mode nil))

(add-hook 'comint-mode-hook 'jakub/set-compilation-text-scale)


; YASnippets
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/jakub/snippets")
(setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/no-prompt yas/x-prompt))


(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
(setq feature-cucumber-command "bundle exec cucumber {options} {feature}")


; Copy & Paste
(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection
(setq select-active-regions t) ;  active region sets primary X11 selection
(global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.
; (setq yank-pop-change-selection t)  ; makes rotating the kill ring change the X11 clipboard.


; Fixing Dired
(defun mydired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (mydired-sort))



(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'dichromacy
   ;; Highlighting faces
   `(highlight ((,class (:foreground unspecified :background "#e5e5e5")))))
  )

(add-to-list 'auto-mode-alist '("\.scss$" . css-mode))


(server-start)
