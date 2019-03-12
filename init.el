
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

  (set-face-attribute 'mode-line nil
                      ;; :background "dark slate gray"
                      :background "gray50"
                      :foreground "#000000"
                      :box nil
                      )
  )

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
  (set-face-attribute 'error nil
                      :foreground "dark red"
                      )
  (set-face-attribute 'success nil
                      :foreground "dark green"
                      )
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
  (beacon-color "yellow")
  :config
  (message ":config beacon")
  (beacon-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :hook
  ((python-mode cc-mode lisp-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character)) ; column

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Interface

(use-package evil
  :ensure t
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
  (minimap-minimum-width 10)
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

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Edit

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
