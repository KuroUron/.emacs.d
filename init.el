
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

;; (use-package hemisu-theme
;;   :ensure t
;;   :init
;;   (use-package gruvbox-theme
;;     :ensure t
;;     :config
;;     (message ":config gruvbox-theme")
;;     (load-theme 'gruvbox-dark-hard t))
;;   :config
;;   (message ":config hemisu-theme")
;;   (load-theme 'hemisu-dark t)

;;   (set-face-attribute 'mode-line nil
;;                       ;; :background "dark slate gray"
;;                       :background "gray50"
;;                       :foreground "#000000"
;;                       :box nil
;;                       )
;;   )

(use-package doom-themes
  :ensure t
  :config
  (message ":config doom-themes")

  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

;; (use-package powerline
;;   :ensure t
;;   :config
;;   (message ":config powerline")
;;   )

;; (use-package atom-dark-theme
;;   :ensure t
;;   :config
;;   (message ":config atom-dark-thme")
;;   (load-theme 'atom-dark t))

;; (use-package doom-themes
;;   :ensure t
;;   ;; :custom
;;   ;; (doom-themes-enable-italic t)
;;   ;; (doom-themes-enable-bold t)
;;   :custom-face
;;   (doom-modeline-bar ((t (
;;                           ;; :background "red"
;;                           :background "#6272a4"
;;                                       ))))
;;   :config
;;   (message ":config doom-themes")
;;   (load-theme 'doom-dracula t)
;;   ;; (doom-themes-neotree-config)
;;   ;; (doom-themes-org-config)
;;   )

(add-hook 'after-init-hook
          '(lambda ()
             (message ":hook global-display-line-numbers-mode")
             (global-display-line-numbers-mode 1)
             (set-face-attribute 'line-number nil
                                 :background "#3c3836"
                                 :foreground "gray"
                                 :height 0.75
                                 )
             (set-face-attribute 'line-number-current-line nil
                                 :background "#504945"
                                 :foreground "#fe8019"
                                 :height 0.75
                                 )
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
  (setq doom-modeline-height 30)
  (setq doom-modeline-bar-width 8)
  ;; (setq doom-modeline-major-mode-color-icon t)
  ;; (set-face-attribute 'error nil
  ;;                     :foreground "dark red"
  ;;                     )
  ;; (set-face-attribute 'success nil
  ;;                     :foreground "dark green"
  ;;                     )
  )

(use-package hide-mode-line
  :ensure t
  :hook
  ((neotree-mode
    ;; imenu-list-minor-mode
    ;; minimap-mode
    )
   . hide-mode-line-mode))

;; (use-package nyan-mode
;;   :ensure t
;;   :defer
;;   :hook (after-init . nyan-mode)
;;   :config
;;   (message ":config nyan-mode"))

;; (use-package dashboard
;;   :ensure t
;;   :config
;;   (message ":config dashboard")
;;   (dashboard-setup-startup-hook))

(use-package volatile-highlights
  :ensure t
  ;; :custom-face
  ;; (vhl/default-face ((nil (:foreground "#FF3333" :background "#FFCDCD"))))
  :config
  (message ":config volatile-highlights")
  (volatile-highlights-mode t)
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
                        'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil)
  )

(use-package fill-column-indicator
  :ensure t
  :config
  (message ":config fill-column-indicator")
  (define-globalized-minor-mode global-fci-mode
    fci-mode (lambda () (fci-mode 1)))
  (global-fci-mode 1)
  ;; (fci-mode 1)
  (setq fci-rule-color "#1C1C1C")
  (setq fci-rule-column 88)
  ;; (setq fci-rule-column 80)
  )

(use-package whitespace
  :ensure t
  :config
  (message ":config whitespace")
  (setq whitespace-style '(face
                           trailing
                           tabs
                           ;; empty
                           ;; space-mark
                           ;; tab-mark
                           ))
  (global-whitespace-mode 1)

  (set-face-foreground 'whitespace-tab "#222222")
  (set-face-underline  'whitespace-tab t)
  (set-face-background 'whitespace-tab nil)
  )

(use-package beacon
  :ensure t
  :custom
  ;; (beacon-color "yellow")
  (beacon-color "#00bfff")
  :config
  (message ":config beacon")
  (beacon-mode 1))

;; (use-package highlight-indent-guides
;;   :ensure t
;;   :hook
;;   ((python-mode c++-mode lisp-mode yaml-mode) . highlight-indent-guides-mode)
;;   :custom
;;   (highlight-indent-guides-auto-enabled t)
;;   (highlight-indent-guides-responsive t)
;;   (highlight-indent-guides-method 'character)) ; column

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Interface

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)       ; for evil-collection
  :config
  (message ":config evil")
  (evil-mode t)

  ;; (setq evil-normal-state-cursor "dark green")
  ;; (setq evil-insert-state-cursor ("dark red" . 2))

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

  ;; Inactivation SPC key for my-space-map
  (add-hook 'compilation-mode-hook
            '(lambda ()
               (define-key compilation-mode-map (kbd "SPC") nil))
            )
  (add-hook 'dired-mode-hook
            '(lambda ()
               (define-key dired-mode-map (kbd "SPC") nil))
            )
  ;; (add-hook 'custom-mode-hook
  ;;           '(lambda ()
  ;;              (define-key compilation-mode-map (kbd "SPC") nil))
  ;;           )
  ;; (define-key undo-tree-visualizer-mode-map (kbd "SPC") 'my-space-map)
  (define-key evil-motion-state-map (kbd "SPC") 'my-space-map)

  ;; my-space-map
  (define-prefix-command 'my-space-map)
  (define-key evil-normal-state-map (kbd "SPC") 'my-space-map)
  (define-key my-space-map (kbd "b") 'ivy-switch-buffer)
  (define-key my-space-map (kbd "SPC") 'counsel-M-x)
  (define-key my-space-map (kbd "f") 'counsel-find-file)
  (define-key my-space-map (kbd "r") 'counsel-recentf)
  (define-key my-space-map (kbd "/") 'swiper)
  ;; (define-key my-space-map (kbd "l") 'recenter-top-bottom)
  (define-key my-space-map (kbd "g") 'evil-force-normal-state)
  (define-key my-space-map (kbd "i") 'imenu-list-smart-toggle) ; TODO
  (define-key my-space-map (kbd "d") '(lambda ()
                                        (interactive)
                                        (kill-buffer (current-buffer))
                                        ))
  (define-key my-space-map (kbd "o") '(lambda ()
                                        (interactive)
                                        (other-window 1)
                                        (evil-normal-state)
                                        ))
  (define-key my-space-map (kbd "ns") 'neotree-show)
  (define-key my-space-map (kbd "nh") 'neotree-hide)
  (define-key my-space-map (kbd "nt") 'neotree-toggle)
  (define-key my-space-map (kbd "nr") 'neotree-refresh)
  (define-key my-space-map (kbd "cm") 'helm-make)

  ;; my-window-map
  (define-prefix-command 'my-window-map)
  (define-key evil-normal-state-map (kbd "u") 'my-window-map)
  (define-key my-window-map (kbd "j") 'split-window-below)
  (define-key my-window-map (kbd "l") 'split-window-right)
  (define-key my-window-map (kbd "o") 'delete-other-windows)
  (define-key my-window-map (kbd "uo") 'split-window-below)
  (define-key my-window-map (kbd "uuo") 'split-window-right)
  (define-key my-window-map (kbd "0") 'delete-window)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (message ":config evil-collection")
  (evil-collection-init))

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

  (use-package all-the-icons-ivy
    :ensure t
    :config
    (message ":config all-the-icons-ivy")
    (all-the-icons-ivy-setup))

  (defun ivy-rich-switch-buffer-icon (candidate)
    (with-current-buffer
        (get-buffer candidate)
      (all-the-icons-icon-for-mode major-mode)))
  (setq ivy-rich--display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-switch-buffer-icon :width 2)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators
             (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path
             (:width (lambda (x)
                       (ivy-rich-switch-buffer-shorten-path
                        x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand)))))

  (ivy-rich-mode 1)
  (setq ivy-format-function #'ivy-format-function-line)
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
  (use-package company-box
    :ensure t
    :hook (company-mode . company-box-mode)
    :config
    (message ":config company-box")
    )
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
  ;; (use-package amx
  ;;   :ensure t)
  )

(use-package neotree
  :ensure t
  :defer
  ;; :commands (neotree-show)
  ;; :after
  ;; projectile
  ;; :hook
  ;; (ivy-mode . neotree-show)
  ;; (find-file . neotree-refresh)
  ;; :commands
  ;; (neotree-show neotree-hide neotree-dir neotree-find)
  :config
  (message ":config neotree")
  (add-hook 'neotree-mode-hook '(lambda ()
                                  (display-line-numbers-mode 0)
                                  (text-scale-decrease 1)
                                  ))
  (setq neo-show-hidden-files t)
  (setq neo-theme 'icons)
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 20)
  ;; (neo-theme 'nerd2)
  )

(use-package minimap
  :ensure t
  :commands
  (minimap-bufname minimap-create minimap-kill)
  :custom
  (minimap-major-modes '(prog-mode))
  (minimap-window-location 'right)
  (minimap-update-delay 0)
  ;; (minimap-update-delay 0.2)
  (minimap-minimum-width 4)
  ;; (minimap-minimum-width 10)
  ;; :bind
  ;; ("M-t m" . ladicle/toggle-minimap)
  ;; :preface
  ;; (defun ladicle/toggle-minimap ()
  ;;   "Toggle minimap for current buffer."
  ;;   (interactive)
  ;;   (if (null minimap-bufname)
  ;;       (minimap-create)
  ;;     (minimap-kill)))
  :config
  (custom-set-faces
   '(minimap-active-region-background
     ((((background dark)) (:background "#555555555555"))
      (t (:background "#C847D8FEFFFF"))) :group 'minimap))
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Programming

(use-package magit
  :ensure t
  ;; :defer t                                ; TODO
  :commands (magit magit-status)
  :config
  (message ":config magit"))

(use-package imenu-list
  :ensure t
  :defer t
  ;; :bind
  ;; ("<f10>" . imenu-list-smart-toggle)
  ;; TODO Consider bind
  :config
  (message ":config imenu-list")
  )

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
    :hook
    (python-mode . blacken-mode)
    :config
    (message ":config blacken")
    ;; (blacken-mode t)
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
  (evil-define-key 'normal python-mode-map (kbd "C-S-j")
    'my-python-async-shell-command)
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (message ":config: markdown-mode"))

(use-package realgud
  :ensure t
  ;; :defer t
  :commands (realgud:pdb realgud:gdb)
  :config
  (message ":config realgud")

  ;; (set-face-attribute 'realgud-bp-line-enabled-face nil
  ;;                     ::underline "red"
  ;;                     )

  (defun my-gdb-print ()
    (interactive)
    (let* ((word (find-tag-default))
           (cmnd (concat "print( " word " )")))
      (save-excursion
        ;; (switch-to-buffer-other-window "*gdb a.exe shell*")
        ;; (set-buffer "*gdb a.exe shell*")
        (other-window 1)
        (insert cmnd)
        (realgud:send-input)
        (other-window 1))))

  (define-key realgud:shortkey-mode-map (kbd "p") 'my-gdb-print)
  )

(use-package helm-make
  :ensure t
  :commands (helm-make)
  :config
  (message ":config helm-make")
 ;; '(helm-make-completion-method (quote ivy))
  (setq helm-make-completion-method 'ivy))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Edit

;; Windows IME
(setq default-input-method "W32-IME")
(setq-default w32-ime-mode-line-state-indicator "[--]")
(setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
(w32-ime-initialize)

(use-package yasnippet
  :ensure t
  :hook
  (python-mode . yas-minor-mode)
  :config
  (message ":config yasnippet")
  (yas-reload-all)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand))

(use-package git-gutter
  :ensure t
  :custom
  (git-gutter:modified-sign "~")
  (git-gutter:added-sign    "+")
  (git-gutter:deleted-sign  "-")
  :custom-face
  (git-gutter:modified ((t (:background "#f1fa8c"))))
  (git-gutter:added    ((t (:background "#50fa7b"))))
  (git-gutter:deleted  ((t (:background "#ff79c6"))))
  :config
  (message ":config git-gutter")
  (global-git-gutter-mode +1)
  )

;; (use-package smooth-scroll
;;   :ensure t
;;   :config
;;   (message ":config smooth-scroll")
;;   (smooth-scroll-mode t)
;;   )

(use-package pt
  :ensure t)

;; (use-package writeroom-mode
;;   :ensure t)

;; TODO bkup

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Other

(add-hook
 'after-init-hook
 '(lambda ()
    (menu-bar-mode 0)
    (tool-bar-mode 0)
    (toggle-scroll-bar 0)
    (column-number-mode t)
    (setq inhibit-startup-message t)
    (setq frame-title-format
          '("emacs " emacs-version (buffer-file-name " - %f")))
    (set-frame-parameter nil 'alpha 99)
    (show-paren-mode t)
    (electric-pair-mode 1)
    (fset 'yes-or-no-p 'y-or-n-p)
    (set-frame-font "Migu 1M-12:antialias=standard")
    ;; (setq scroll-conservatively 6)

    ;; Key binding
    (define-key global-map (kbd "C-h") (kbd "DEL"))
    (define-key global-map (kbd "C-<tab>") 'dabbrev-expand)
    (global-set-key (kbd "C-8") 'start-kbd-macro)
    (global-set-key (kbd "C-9") 'end-kbd-macro)
    (global-set-key (kbd "C-0") 'call-last-kbd-macro)

    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 8)
    (add-hook 'before-save-hook 'delete-trailing-whitespace)
    (setq set-mark-command-repeat-pop t)
    ))


;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; @ auto
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(helm-make-completion-method (quote ivy))
;;  '(package-selected-packages
;;    (quote
;;     (helm-make smooth-scroll realgud markdown-mode nyan-mode yasnippet writeroom-mode which-key volatile-highlights use-package neotree minimap magit ivy-rich imenu-list hydra highlight-indent-guides hide-mode-line hemisu-theme gruvbox-theme git-gutter fill-column-indicator evil doom-themes doom-modeline counsel company-box clang-format blacken beacon all-the-icons-ivy))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(git-gutter:added ((t (:background "#50fa7b"))))
;;  '(git-gutter:deleted ((t (:background "#ff79c6"))))
;;  '(git-gutter:modified ((t (:background "#f1fa8c")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-collection yasnippet writeroom-mode which-key volatile-highlights use-package smooth-scroll realgud nyan-mode neotree minimap markdown-mode magit ivy-rich imenu-list hydra highlight-indent-guides hide-mode-line hemisu-theme helm-make gruvbox-theme git-gutter fill-column-indicator evil doom-themes doom-modeline counsel company-box clang-format blacken beacon all-the-icons-ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added ((t (:background "#50fa7b"))))
 '(git-gutter:deleted ((t (:background "#ff79c6"))))
 '(git-gutter:modified ((t (:background "#f1fa8c")))))
