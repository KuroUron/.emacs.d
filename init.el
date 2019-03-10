
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Init

(prefer-coding-system 'utf-8)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (locate-library "use-package")
  (message "Install use-package")
  (package-refresh-contents)
  (package-install 'use-package)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Appearance

(use-package hemisu-theme
  :ensure t
  :init
  (use-package gruvbox-theme
    :ensure t
    :config
    (message ":config gruvbox-theme")
    (load-theme 'gruvbox-dark-hard t))
  :config
  (message ":config hemisu-theme")
  (load-theme 'hemisu-dark t)
  )

(add-hook 'after-init-hook
	  '(lambda ()
	     (message ":hook global-display-line-numbers-mode")
	     (global-display-line-numbers-mode 1)
	     ))

(use-package all-the-icons
  ;; NOTE For a new environment, call `M-x all-the-icons-install-fonts` and
  ;; download fonts. Then intall those fonts **manually**.
  :ensure t
  :defer t
  :config
  (message ":config all-the-icons"))

(use-package doom-modeline
  :ensure t
  :defer t
  :hook (after-init . doom-modeline-mode)
  :config
  (message ":config doom-modeline")
  )

;; (use-package hide-mode-line
;;   :hook
;;   ((neotree-mode imenu-list-minor-mode minimap-mode) . hide-mode-line-mode))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Interface

(use-package evil
  :ensure t
  :config
  (message ":config evil")
  (evil-mode t)

  ;; evil-normal-state-map
  (define-key evil-normal-state-map (kbd "s") 'swiper)
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
	 (activate-mark)
	 )))
  (defun my-get-file-path ()
    (interactive)
    (let* ((file-name (buffer-file-name))
           (file-path (file-name-directory file-name)))
      (message (concat "Get file path: " file-path))
      (kill-new file-path)
      ))
  (define-key evil-normal-state-map (kbd "@") 'my-get-file-path)
  (defun my-cd-current-file-directory ()
    (interactive)
    (let* ((file-path (my-get-file-path))
           (command (concat "cd " file-path)))
      (shell)
      (end-of-buffer)
      (kill-new command)
      (yank)
      (comint-send-input)
      ))
  (define-key evil-normal-state-map (kbd "`") 'my-cd-current-file-directory)
  
  ;; my-space-map
  (define-prefix-command 'my-space-map)
  (define-key evil-normal-state-map (kbd "SPC") 'my-space-map)
  (define-key my-space-map (kbd "SPC") 'counsel-M-x)
  (define-key my-space-map (kbd "f") 'counsel-find-file)
  (define-key my-space-map (kbd "b") 'counsel-switch-buffer)
  (define-key my-space-map (kbd "r") 'counsel-recentf)
  (define-key my-space-map (kbd "/") 'swiper)
  ;; (define-key my-space-map (kbd "l") 'recenter-top-bottom)
  (define-key my-space-map (kbd "g") 'evil-force-normal-state)
  (define-key my-space-map (kbd "d") '(lambda ()
					(interactive)
  					(kill-buffer (current-buffer))
					))
  (define-key my-space-map (kbd "o") '(lambda ()
					(interactive)
					(other-window 1)
					(evil-normal-state)
					))

  ;; my-window-map
  (define-prefix-command 'my-window-map)
  (define-key evil-normal-state-map (kbd "u") 'my-window-map)
  (define-key my-window-map (kbd "j") 'split-window-below)
  (define-key my-window-map (kbd "l") 'split-window-right)
  (define-key my-window-map (kbd "o") 'delete-other-windows)

  )

(use-package ivy
  :ensure t  
  :defer t
  :config
  (message ":config ivy")
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1)
  )

(use-package ivy-rich
  :ensure t
  :after ivy
  :config
  (message ":config ivy-rich")
  (setq ivy-format-function #'ivy-format-function-line)
  (ivy-rich-mode 1)
  )

(use-package counsel
  :ensure t
  :after ivy
  :config
  (message ":config counsel")
  (counsel-mode 1)
  )

(use-package swiper
  :ensure t  
  :after ivy
  :config
  (message ":config swiper")
  ;; :bind (("C-s" . swiper)
  ;;        ("C-r" . swiper))
  )

(use-package company
  :ensure t
  :after ivy
  :config
  (message ":config company")
  (global-company-mode t)
  (setq company-idle-delay 0) 
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t) 
  )

(use-package hydra
  :ensure t
  :after ivy
  :config
  (message ":config hydra")
  (defhydra hydra-space (evil-normal-state-map "SPC")
    ("j" (lambda () (interactive) (evil-next-line 5)))
    ("k" (lambda () (interactive) (evil-previous-line 5)))
    ("h" (lambda () (interactive) (evil-backward-char 5)))
    ("l" (lambda () (interactive) (evil-forward-char 5)))
    ("g" nil "leave")
    )
  )

(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode)
  :config
  (message ":config which-key")
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Edit

;; (use-package yasnippet
;;   :ensure t
;;   :config
;;   (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand))

;; (use-package writeroom-mode
;;   :ensure t)

;; TODO bkup

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Programming

(use-package magit
  :ensure t
  :config
  (message ":config magit"))

(use-package cc-mode
  :mode (("\\.cpp" . c++-mode)
	 ("\\.cc" . c++-mode)
	 ("\\.smp" . c++-mode))
  :config
  (message ":config cc-mode")
  (use-package clang-format
    :ensure t
    :config
    (message ":config clang-format")
    (define-key evil-normal-state-map (kbd "f")
      '(lambda (start end)
	 (interactive
          (if (use-region-p)
              (list (region-beginning) (region-end))
            (list (point) (point))))
	 (clang-format-region start end)
	 )))
  )
  
(use-package python
  :defer t
  :mode (("\\.py" . python-mode))
  :config
  (message ":config python")

  (use-package blacken
    :ensure t
    :config
    (message ":config blacken")
    (blacken-mode t)
    )

  (defun my-python-run ()
    (interactive)
    (let ((command (concat "python " (file-name-base) ".py")))
      (save-buffer)
      (async-shell-command command)
      ))
  
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
					(dired-get-filename nil t))
				       )))
				 (and filename (file-relative-name filename))))
	   current-prefix-arg
	   shell-command-default-error-buffer
	   ))
    (save-buffer)
    (unless (string-match "&[ \t]*\\'" command)
      (setq command (concat command " &")))
    (shell-command command output-buffer error-buffer))

  (evil-define-key 'normal python-mode-map (kbd "C-j") 'my-python-run)
  (evil-define-key 'normal python-mode-map (kbd "C-S-j") 'my-python-async-shell-command)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Other

(add-hook
 'after-init-hook
 '(lambda ()
    (menu-bar-mode 0)
    (tool-bar-mode 0)
    (toggle-scroll-bar 0)
    (column-number-mode t)
    (setq frame-title-format
	  '("emacs " emacs-version (buffer-file-name " - %f")))
    (set-frame-parameter nil 'alpha 98)
    (show-paren-mode t)
    (electric-pair-mode 1)
    (fset 'yes-or-no-p 'y-or-n-p)
    (set-frame-font "Migu 1M-13:antialias=standard")

    ;; Key binding
    (define-key global-map (kbd "C-h") (kbd "DEL"))
    (define-key global-map (kbd "C-<tab>") 'dabbrev-expand)
    (global-set-key (kbd "C-8") 'start-kbd-macro)
    (global-set-key (kbd "C-9") 'end-kbd-macro)
    (global-set-key (kbd "C-0") 'call-last-kbd-macro)
    ))


;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; @ auto

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit which-key use-package-hydra ivy-rich hydra hemisu-theme gruvbox-theme evil doom-modeline counsel company clang-format blacken))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
