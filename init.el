(require 'package)
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/")  t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade"."http://marmalade-repo.org/packages/") t)
(package-initialize)

;; (switch-to-buffer (cadr ))
;; (buffer-list)


; (require 'org-trello)
; (add-hook 'org-mode-hook 'org-trello-mode)


(require 'find-file-in-git-repo)
(require 'yasnippet)
(require 'buffer-move)
(require 'erc)
(require 'expand-region)
(require 'auto-shell-command)
(require 'flymake-coffee)
(require 'dired-open)

 (require 'dired-x)
;    (setq-default dired-omit-files-p t) ; Buffer-local variable
  (defun dired-dotfiles-toggle ()
    "Show/hide dot-files"
    (interactive)
    (when (equal major-mode 'dired-mode)
      (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
	  (progn
	    (set (make-local-variable 'dired-dotfiles-show-p) nil)
	    (message "h")
	    (dired-mark-files-regexp "^\\\.")
	    (dired-do-kill-lines))
	(progn (revert-buffer) ; otherwise just revert to re-show
	       (set (make-local-variable 'dired-dotfiles-show-p) t)))))




(ascmd:remove-all)
; (ascmd:add '("home.html.liquid" "curl -X PUT --data-urlencode 'template[draft]@/home/jakub/prog/3scale/system/lib/liquid/template/buyer_side/home.html.liquid' 'http://jakub-admin.3scale.net.dev:3000/admin/api/cms/templates/1929715.xml?provider_key=49a2fe3245e1ff5af2487c8acacea277'"))


(when (not package-archive-contents)
  (package-refresh-contents))


(define-key global-map (kbd "C-c h") 'help-command)
(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map (kbd "C-M-h") 'backward-kill-word)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)




; Miscelaneous setq'
(setq tab-width 2)
(setq sass-indent-offset 2)

(setq require-final-newline nil)
(setq truncate-lines nil)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")


(remove-hook 'text-mode-hook 'turn-on-auto-fill)

; TODO loop and do it after save
(add-hook 'prog-mode-hook 'delete-trailing-whitespace)
(add-hook 'ruby-mode-hook 'delete-trailing-whitespace)
;; (add-hook 'scss-mode-hook 'delete-trailing-whitespace)
;; (add-hook 'javascript-mode-hook 'delete-trailing-whitespace)
;; (add-hook 'html-mode-hook 'delete-trailing-whitespace)
;; (add-hook 'coffee-mode-hook 'delete-trailing-whitespace)

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

(add-hook 'handlebars-mode-hook (lambda ()
  (local-set-key (kbd "C-c c") 'sgml-close-tag)))




; Coffee mode hook overrides this by default
(add-hook 'coffee-mode-hook '(lambda ()
                               (local-set-key (kbd "C-M-h") 'backward-kill-word)
                               ))
(add-hook 'coffee-mode-hook 'flymake-coffee-load)


(defun jakub/set-compilation-text-scale ()
  (text-scale-adjust -1)
  (setq truncate-mode nil))

(add-hook 'comint-mode-hook 'jakub/set-compilation-text-scale)


; YASnippets
       (require 'dropdown-list)
      (setq yas-prompt-functions '(yas-dropdown-prompt
                                   yas-ido-prompt
                                   yas-completing-prompt))


;  "/home/jakub/prog/vendor/yasmate/snippets"
;(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;; TODO - snippets
;; (add-hook 'handlebars-mode-hook lambda () (
;;                                       (set (make-local-variable 'yas--extra-modes) '(html-mode))
;;                                       ))



(add-to-list 'auto-mode-alist '("\\.emblem$" . slim-mode))
(add-to-list 'auto-mode-alist '("\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
(setq feature-cucumber-command "be cu {options} {feature}")


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
 '(bongo-enabled-backends (quote (mpg123)))
 '(custom-safe-themes
   (quote
    ("baec1c1685293d66ec4c623683ed87bbf7fc3ce4ccbaeca878c9b8ac8c3ab7b3" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(safe-local-variable-values
   (quote
    ((require-final-newline)
     (encoding . utf-8)
     (whitespace-line-column . 80)
     (lexical-binding . t))))
 '(wtf-custom-alist (quote (("TIL" . "today I learnt")))))
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


; (define-key local-map (kbd "C-c C-n") (lambda () (interactive) (insert "ñ")))


;
; Ibuffer - organized buffer list
(global-set-key (kbd "C-x C-b") 'ibuffer)


(setq ibuffer-saved-filter-groups
      '(("work"
	 ("emacs-config" (or (filename . ".emacs.d")
			     (filename . "emacs-config")))
	 ("Org" (or (mode . org-mode)
		    (filename . "OrgMode")))
	 ("system" (filename . "3scale/system/"))
   ("backend" (filename . "3scale/backend/"))
   ("november" (filename . "3scale/november/"))
   ("october" (filename . "3scale/october/"))
	 ("ssh" (or (name . "\*tramp.*")
              (name . "/scpc")
              ))

   ("Magit" (name . "\*magit"))
	 ("ERC" (mode . erc-mode))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))




(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "work")))

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(define-key global-map (kbd "C-c C-SPC") 'bongo-pause/resume)
(define-key global-map (kbd "C-<left>") 'bongo-seek-backward-10)
(define-key global-map (kbd "C-<right>") 'bongo-seek-backward-10)
(define-key global-map (kbd "C-<down>") 'bongo-pause/resume)

(fset 'rails-schema-attribute
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([19 34 13 67108896 1 23 19 34 67108896 2 67108896 5 23 1] 0 "%d")) arg)))
