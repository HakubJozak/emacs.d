(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)


(require 'find-file-in-git-repo)
(require 'yasnippet)
(require 'buffer-move)
(require 'yasnippet)
(require 'feature-mode)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(yasnippet
                      multi-term
                      scss-mode
                      feature-mode
                      gist
                      buffer-move
                      find-file-in-git-repo
                      starter-kit
                      starter-kit-lisp
                      starter-kit-js
                      starter-kit-ruby
                      starter-kit-bindings)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(define-key global-map (kbd "C-c h") 'help-command)
(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map (kbd "C-M-h") 'backward-kill-word)




; Miscelaneous setq'
(setq tab-width 2)
(setq sass-indent-offset 2)

(setq require-final-newline nil)
(setq truncate-lines nil)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")


(remove-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'scss-mode-hook 'delete-trailing-whitespace)
(setq scss-compile-at-save nil)


; IDo
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
(setq ido-default-file-method "selected-window"
      ido-default-buffer-method "selected-window")

; Windows & Buffers
(winner-mode)

; http://stackoverflow.com/questions/1774832/how-to-swap-the-buffers-in-2-windows-emacs
(defun window-swap () "Swap windows using buffer-move.el"
  (interactive)
  (if (null (windmove-find-other-window 'right))
      (buf-move-left) (buf-move-right))
  (ignore-errors (windmove-left))
  )

(global-set-key (kbd "C-c C-s") 'window-swap)


; Keys
(global-set-key (kbd "C-x f") 'find-file-in-git-repo)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c [") 'winner-undo)
(global-set-key (kbd "C-c ]") 'winner-redo)
(global-set-key (kbd "C-c g") 'vc-git-grep)
(global-set-key (kbd "C-c C-c [") 'multi-term-prev)
(global-set-key (kbd "C-c C-c ]") 'multi-term-next)


(add-hook 'coding-hook (lambda ()
  (local-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
  (local-set-key (kbd "C-c f") 'er/expand-region)
  (local-set-key (kbd "C-c b") 'er/contract-region)))



(defun jakub/set-compilation-text-scale ()
  (text-scale-adjust -1)
  (setq truncate-mode nil))

(add-hook 'comint-mode-hook 'jakub/set-compilation-text-scale)


; YASnippets
(yas/initialize)
(yas/load-directory "~/.emacs.d/jakub/snippets")

(if
 (listp yas/root-directory)
    (add-to-list 'yas/root-directory  "~/.emacs.d/jakub/snippets")
    (setq yas/root-directory (list  "~/.emacs.d/jakub/snippets" yas/root-directory))
  )

(setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/no-prompt yas/x-prompt))

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

(defun my-dired-setup ()
  (interactive)
  (local-set-key (kbd "C-j") 'browse-url-of-dired-file)
  )

(add-hook 'dired-mode-hook 'my-dired-setup)


(server-start)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(safe-local-variable-values (quote ((encoding . utf-8) (whitespace-line-column . 80) (lexical-binding . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; (setq ffap-alist                   ; add something to `ffap-alist'
;; 	 (cons
;; 	  (cons "#dev"
;; 		(defun ffap-erc (name)
;;                   "BCMSECTOMY"))
;; 	  ffap-alist))
