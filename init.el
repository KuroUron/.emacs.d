
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ package

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(prefer-coding-system 'utf-8)
(package-initialize)
;; (package-refresh-contents)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ theme

(use-package hemisu-theme
  :ensure t
  :config
  (use-package gruvbox-theme
    :ensure t
    :config (load-theme 'gruvbox-dark-hard t))
  (load-theme 'hemisu-dark t))

;; (use-package ir-black-theme
;;   :ensure t
;;   :config
;;   (load-theme 'ir-black t))

;; (use-package gruvbox-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruvbox-dark-hard t))

;; (use-package klere-theme
;;   :ensure t
;;   :config
;;   (load-theme 'klere t))

;; (use-package hemisu-theme
;;   :ensure t
;;   :config
;;   (load-theme 'hemisu-light t))

;; (use-package doom-themes 
;;   :ensure t
;;   :config
;;   (load-theme 'doom-dracula t))

;; (use-package doom-themes 
;;   :ensure t
;;   :custom
;;   (doom-themes-enable-italic t)
;;   (doom-themes-enable-bold t)
;;   :custom-face
;;   (doom-modeline-bar ((t (:background "#6272a4"))))
;;   :config
;;   (load-theme 'doom-dracula t)
;;   (doom-themes-neotree-config)
;;   (doom-themes-org-config))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ linum

(use-package linum
  :ensure t
  :config
  (add-hook 'find-file-hook (lambda () (linum-mode 1)))
  (setq linum-format "%5d")
  (set-face-attribute 'linum nil :height 0.8)
  (setq linum-delay t)
  (defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ evil

(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (define-key evil-normal-state-map (kbd "s") 'swiper)
  ;; (define-key evil-normal-state-map (kbd "i") 'evil-emacs-state)
  (define-key evil-normal-state-map (kbd "m")
    '(lambda ()
       "Mark a word around the cursor."
       (interactive)
       (let ((word (find-tag-default)))
	 ;; For EOF
	 (if (> (+ (point) (length word)) (point-max))
	     (progn
	       (goto-char (point-max))
	       (message "Near EOF"))
	   (forward-char (length word)))
	 (word-search-backward word)
	 (push-mark)
	 (word-search-forward word)
	 (backward-char 1)
	 (message word)
	 (activate-mark))))

  (defun my-get-file-path ()
    (interactive)
    (let* ((file-name (buffer-file-name))
           (file-path (file-name-directory file-name)))
      (message (concat "Get file path: " file-path))
      (kill-new file-path)))
  (define-key evil-normal-state-map (kbd "@") 'my-get-file-path)
  ;; (defun my-cd-current-file-directory ()
  ;;   (interactive)
  ;;   (let* ((file-path (my-get-file-path))
  ;;          (command (concat "cd " file-path)))
  ;;     ;; (split-window-below)
  ;;     ;; (other-window 1)
  ;;     (shell)
  ;;     (end-of-buffer)
  ;;     (kill-new command)
  ;;     (yank)
  ;;     (comint-send-input)))
  ;; (define-key evil-normal-state-map (kbd "S-@") 'my-cd-current-file-directory)
  
  ;; my-space-map
  (define-prefix-command 'my-space-map)
  (define-key evil-normal-state-map (kbd "SPC") 'my-space-map)
  (define-key my-space-map (kbd "SPC") 'counsel-M-x)
  (define-key my-space-map (kbd "f") 'counsel-find-file)
  (define-key my-space-map (kbd "b") 'ivy-switch-buffer)
  (define-key my-space-map (kbd "l") 'recenter-top-bottom)
  (define-key my-space-map (kbd "g") 'evil-force-normal-state)
  (define-key my-space-map (kbd "/") 'swiper)
  (define-key my-space-map (kbd "r") 'counsel-recentf)
  (define-key my-space-map (kbd "d") '(lambda ()
					(interactive)
  					(kill-buffer (current-buffer))))
  (define-key my-space-map (kbd "o") '(lambda ()
					(interactive)
					(other-window 1)
					(evil-normal-state)))

    ;; other-window

  ;; my-window-map
  (define-prefix-command 'my-window-map)
  (define-key evil-normal-state-map (kbd "u") 'my-window-map)
  (define-key my-window-map (kbd "j") 'split-window-below)
  (define-key my-window-map (kbd "l") 'split-window-right)
  ;; (define-key my-window-map (kbd "o") 'other-window)
  (define-key my-window-map (kbd "o") 'delete-other-windows)

  ;; hydra
  (use-package hydra
    :ensure t
    :config
    
    ;; Sample hydra
    (defhydra hydra-zoom (global-map "<f2>")
      "zoom"
      ("g" text-scale-increase "in")
      ("l" text-scale-decrease "out"))
    
    ;; Hydra move
    (defhydra hydra-space (evil-normal-state-map "SPC")
      ("j" (lambda () (interactive) (evil-next-line 5)))
      ("k" (lambda () (interactive) (evil-previous-line 5)))
      ("h" (lambda () (interactive) (evil-backward 5)))
      ("l" (lambda () (interactive) (evil-forward-char 5)))
      ("g" nil "leave")
      )

    (defhydra hydra-buffer-menu (:color pink)
      "
  Mark               Unmark             Actions            Search
-------------------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete                           _g_: refresh       _O_: multi-occur
_D_: delete up                        _T_: files only: %`Buffer-menu-files-only
_~_: modified
"
      ("m" Buffer-menu-mark nil)
      ("u" Buffer-menu-unmark nil)
      ("U" Buffer-menu-backup-unmark nil)
      ("d" Buffer-menu-delete nil)
      ("D" Buffer-menu-delete-backwards nil)
      ("s" Buffer-menu-save nil)
      ("~" Buffer-menu-not-modified nil)
      ("x" Buffer-menu-execute nil)
      ("b" Buffer-menu-bury nil)
      ("g" revert-buffer nil)
      ("T" Buffer-menu-toggle-files-only nil)
      ("O" Buffer-menu-multi-occur nil :color blue)
      ("I" Buffer-menu-isearch-buffers nil :color blue)
      ("R" Buffer-menu-isearch-buffers-regexp nil :color blue)
      ("c" nil "cancel")
      ("v" Buffer-menu-select "select" :color blue)
      ("o" Buffer-menu-other-window "other-window" :color blue)
      ("q" quit-window "quit" :color blue))
    
    (define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)
    
    
    )
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ counsel/ivy/swiper

(use-package ivy
  :ensure t  
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config
  ;; (setq ivy-initial-inputs-alist nil)  
  (ivy-mode))

(use-package ivy-rich
  :ensure t
  :config
  (setq ivy-format-function #'ivy-format-function-line)
  (ivy-rich-mode 1)
  )

(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode)
  )

(use-package swiper
  :ensure t  
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ company

(use-package company
  :ensure t
  :config
  (global-company-mode))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ modeline

(use-package all-the-icons
  :ensure t)
;; NOTE For a new environment, call `M-x all-the-icons-install-fonts` and download fonts.
;; Then intall those fonts **manually**.

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package hide-mode-line
  :hook
  ((neotree-mode imenu-list-minor-mode minimap-mode) . hide-mode-line-mode))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ which-key

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ yasnippet

(use-package yasnippet
  :ensure t
  :config
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ cc-mode, cpp

(use-package cc-mode
  :defer t
  :mode (("\\.smp" . c++-mode))
  ;; :config
  )

(use-package clang-format
  :ensure t
  :after cc-mode
  :config
  (define-key evil-normal-state-map (kbd "f")
    '(lambda (start end)
       (interactive
        (if (use-region-p)
            (list (region-beginning) (region-end))
          (list (point) (point))))
       (clang-format-region start end))))
  

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ python

(use-package python
  :defer t
  :config

  (defun my-python-run ()
    (interactive)
    (let ((command (concat "python " (file-name-base) ".py")))
      (save-buffer)
      (async-shell-command command)))
  
  (defun my-python-async-shell-command
      (command &optional output-buffer error-buffer)
    (interactive
     (list (read-shell-command "Async shell command: "
                               (concat "python " (file-name-base) ".py ")
                               nil
                               (let ((filename
                                      (cond
                                       (buffer-file-name)
                                       ((eq major-mode 'dired-mode)
					(dired-get-filename nil t)))))
				 (and filename (file-relative-name filename))))
	   current-prefix-arg
	   shell-command-default-error-buffer))
    (save-buffer)
    (unless (string-match "&[ \t]*\\'" command)
      (setq command (concat command " &")))
    (shell-command command output-buffer error-buffer))

  (evil-define-key 'normal python-mode-map (kbd "C-j") 'my-python-run)
  (evil-define-key 'normal python-mode-map (kbd "C-S-j") 'my-python-async-shell-command)
  )

(use-package blacken
  :ensure t
  :after python
  :init
  (add-hook 'python-mode-hook 'blacken-mode)
  ;; :hook (python-mode-hook . blacken-mode)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ write-root

(use-package writeroom-mode
  :ensure t)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ bkup

;; TODO

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ key binding

(define-key global-map (kbd "C-h") (kbd "DEL"))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ other

(setq frame-title-format
      '("emacs " emacs-version (buffer-file-name " - %f")))
(set-frame-parameter nil 'alpha 98)
(menu-bar-mode 0)
(tool-bar-mode 0)
(toggle-scroll-bar 0)
(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)
;; (setq frame-title-format "")
;; (set-frame-parameter nil 'undecorated t)
;; (ns-use-proxy-icon nil)

;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; assuming you are using a dark theme
;; (setq ns-use-proxy-icon nil)
;; (setq frame-title-format nil)

;; Dabbrev
(define-key global-map (kbd "C-<tab>") 'dabbrev-expand)

;; Insert closing parenthesis automatically
(electric-pair-mode 1)

;; Simplify queries
(fset 'yes-or-no-p 'y-or-n-p)

;; In order to check available font families, eval `(font-family-list)`.
;; (set-face-font 'default "Migu 1M-14")
(set-frame-font "Migu 1M-13:antialias=standard")

;; Macro
(global-set-key (kbd "C-8") 'start-kbd-macro)
(global-set-key (kbd "C-9") 'end-kbd-macro)
(global-set-key (kbd "C-0") 'call-last-kbd-macro)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ auto

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-use-virtual-buffers t)
 '(package-selected-packages
   (quote
    (clang-format blacken yasnippet writeroom-mode gruvbox-theme klere-theme ir-black-theme cyberpunk-theme hemisu-theme hemisu-dark use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4")))))
