;; TODO set-mark-command-repeat-pop の振る舞いを変更 (my-space-map ?)

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

(menu-bar-mode 0)
(tool-bar-mode 0)
(toggle-scroll-bar 0)

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

  (when (eq system-type 'windows-nt)
    (load-theme 'doom-one t)
    )
  (when (eq system-type 'gnu/linux)
    (load-theme 'doom-dracula t)
    )

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
;;   ;; :custom-face
;;   ;; (doom-modeline-bar ((t (
;;   ;;                         ;; :background "red"
;;   ;;                         :background "#6272a4"
;;   ;;                         ))))
;;   :config
;;   (message ":config doom-themes")
;;   (load-theme 'doom-one t)
;;   ;; (load-theme 'doom-dracula t)
;;   ;; (doom-themes-neotree-config)
;;   ;; (doom-themes-org-config)
;;   )

(add-hook 'ivy-mode-hook
          ;; 'after-init-hook
          '(lambda ()
             (message ":hook global-display-line-numbers-mode")
             (global-display-line-numbers-mode 1)
             (set-face-attribute 'line-number nil
                                 ;; :background "#3c3836"
                                 ;; :foreground "gray"
                                 :height 0.8
                                 )
             (set-face-attribute 'line-number-current-line nil
                                 :background "#504945"
                                 :foreground "#fe8019"
                                 :height 0.8
                                 )
             ))

(use-package all-the-icons
  ;; NOTE For a new environment, call `M-x all-the-icons-install-fonts` and
  ;; download fonts. Then intall those fonts **manually**.
  :ensure t
  ;; :defer t
  :after ivy
  :config
  (message ":config all-the-icons")
  )

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

;; (use-package volatile-highlights
;;   :ensure t
;;   ;; :custom-face
;;   ;; (vhl/default-face ((nil (:foreground "#FF3333" :background "#FFCDCD"))))
;;   :config
;;   (message ":config volatile-highlights")
;;   (volatile-highlights-mode t)
;;   (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
;;                         'evil-paste-pop 'evil-move)
;;   (vhl/install-extension 'evil)
;;   )

;; (use-package fill-column-indicator
;;   :ensure t
;;   ;; :defer t
;;   :after ivy
;;   :config
;;   (message ":config fill-column-indicator")
;;   (define-globalized-minor-mode global-fci-mode
;;     fci-mode (lambda () (fci-mode 1)))
;;   (global-fci-mode 1)
;;   ;; (fci-mode 1)
;;   ;; (setq fci-rule-color "#1C1C1C")
;;   ;; (setq fci-rule-color "#3f444a")       ; same as line number color
;;   (setq fci-rule-color "#373B47")       ; same as doom modeline color
;;   (setq fci-rule-column 88)
;;   ;; (setq fci-rule-column 80)
;;   )

(use-package whitespace
  :ensure t
  :after ivy
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
  ;; (beacon-color "orange")
  (beacon-color "#00bfff")
  ;; (beacon-color "#51afef")              ; cursor blue

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
  ;; (define-key evil-motion-state-map (kbd "<tab>") nil)  ; TODO
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

  ;; ;; evil-insert-state-map
  (define-key evil-insert-state-map (kbd "M-h") 'backward-kill-word)
  (define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
  (define-key evil-insert-state-map (kbd "C-p") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-n") 'next-line)
  (define-key evil-insert-state-map (kbd "C-k") 'kill-line)

  ;; Inactivation SPC key for my-space-map
  (add-hook 'compilation-mode-hook
            '(lambda ()
               (define-key compilation-mode-map (kbd "SPC") nil)
               ))
  (add-hook 'dired-mode-hook
            '(lambda ()
               (define-key dired-mode-map (kbd "SPC") nil)
               ))
  ;; (add-hook 'compilation-mode-hook
  ;;           '(lambda ()
  ;;              (define-key compilation-mode-map (kbd "SPC") nil)
  ;;              ))
  ;; (add-hook 'help-mode-hook
  ;;           '(lambda ()
  ;;              (define-key help-mode-map (kbd "SPC") nil)
  ;;              ))                       ; TODO
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
  ;; (define-key my-space-map (kbd "g") 'evil-force-normal-state)
  (define-key my-space-map (kbd "g") 'magit-status)
  (define-key my-space-map (kbd "i") 'imenu-list-smart-toggle) ; TODO
  ;; (define-key my-space-map (kbd "d") '(lambda ()
  ;;                                       (interactive)
  ;;                                       (kill-buffer (current-buffer))
  ;;                                       ))
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
  (define-key my-space-map (kbd "@") 'my-cd-current-file-directory)
  (define-key my-space-map (kbd "tf") 'toggle-frame-fullscreen)
  (define-key my-space-map (kbd "uo") 'toggle-frame-fullscreen)
  (define-key my-space-map (kbd "J") 'smooth-scroll/scroll-up)
  (define-key my-space-map (kbd "dk") 'describe-key)
  (define-key my-space-map (kbd "dv") 'describe-variable)
  (define-key my-space-map (kbd "df") 'describe-function)
  (define-key my-space-map (kbd "dm") 'describe-mode)
  (define-key my-space-map (kbd "dt") 'describe-theme)

  ;; my-window-map
  (define-prefix-command 'my-window-map)
  (define-key evil-normal-state-map (kbd "u") 'my-window-map)
  (define-key my-window-map (kbd "j") 'split-window-below)
  (define-key my-window-map (kbd "l") 'split-window-right)
  (define-key my-window-map (kbd "o") 'delete-other-windows)
  ;; (define-key my-window-map (kbd "uo") 'split-window-below)
  ;; (define-key my-window-map (kbd "uuo") 'split-window-right)
  (define-key my-window-map (kbd "0") 'delete-window)
  (define-key my-window-map (kbd "k") 'toggle-frame-fullscreen)
  ;; (define-key my-window-map (kbd "uuo") 'toggle-frame-fullscreen)
  (define-key my-window-map (kbd "uo") 'toggle-frame-fullscreen)
  )

(use-package evil-collection
  :ensure t
  ;; :after evil
  :after ivy
  :config
  (message ":config evil-collection")
  (evil-collection-init)
  )

(use-package evil-magit
  :after magit
  :ensure t
  :config
  (message ":config evil-magit")
  )

;; (use-package modalka
;;   :ensure t
;;   :config
;;   (message ":config modalka")
;;   (modalka-define-kbd "W" "M-w")
;;   (modalka-define-kbd "Y" "M-y")
;;   (modalka-define-kbd "a" "C-a")
;;   (modalka-define-kbd "b" "C-b")
;;   (modalka-define-kbd "e" "C-e")
;;   (modalka-define-kbd "f" "C-f")
;;   (modalka-define-kbd "g" "C-g")
;;   (modalka-define-kbd "n" "C-n")
;;   (modalka-define-kbd "p" "C-p")
;;   (modalka-define-kbd "w" "C-w")
;;   (modalka-define-kbd "y" "C-y")
;;   (modalka-define-kbd "SPC" "C-SPC")
;;   )

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

  (defun ivy-rich-switch-buffer-icon (candidate)
    (with-current-buffer
   	(get-buffer candidate)
      (let ((icon (all-the-icons-icon-for-mode major-mode)))
        (if (symbolp icon)
            (all-the-icons-icon-for-mode 'fundamental-mode)
          icon))))
  (setq ivy-rich--display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-switch-buffer-icon :width 2)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path
             (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path
                                  x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand)))))

  (setq ivy-format-function #'ivy-format-function-line)
  (ivy-rich-mode t)
  ;; (use-package all-the-icons-ivy
  ;;   :ensure t
  ;;   :config
  ;;   (message ":config all-the-icons-ivy")
  ;;   (all-the-icons-ivy-setup)
  ;;   (defun ivy-rich-switch-buffer-icon (candidate)
  ;;     (with-current-buffer
  ;;         (get-buffer candidate)
  ;;       (all-the-icons-icon-for-mode major-mode)))
  ;;   (setq ivy-rich--display-transformers-list
  ;;         '(ivy-switch-buffer
  ;;           (:columns
  ;;            ((ivy-rich-switch-buffer-icon :width 2)
  ;;             (ivy-rich-candidate (:width 30))
  ;;             (ivy-rich-switch-buffer-size (:width 7))
  ;;             (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
  ;;             (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
  ;;             (ivy-rich-switch-buffer-project (:width 15 :face success))
  ;;             (ivy-rich-switch-buffer-path
  ;;              (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path
  ;;                                   x (ivy-rich-minibuffer-width 0.3))))))
  ;;            :predicate
  ;;            (lambda (cand) (get-buffer cand)))))
  ;;   (ivy-rich-mode t)
  ;;   )
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
  ;; (use-package company-box
  ;;   :ensure t
  ;;   :hook (company-mode . company-box-mode)
  ;;   :config
  ;;   (message ":config company-box")
  ;;   )
  (global-company-mode t)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)

  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  )

(use-package hydra
  :ensure t
  :after ivy
  :config
  (message ":config hydra")
  (defhydra hydra-space (evil-normal-state-map "SPC")
    ;; ("j" (lambda () (interactive) (evil-next-line 5)))
    ("j" (lambda () (interactive) (evil-next-line 5)))
    ("k" (lambda () (interactive) (evil-previous-line 5)))
    ("h" (lambda () (interactive) (evil-backward-char 5)))
    ("l" (lambda () (interactive) (evil-forward-char 5)))
    ("g" nil "leave")
    )

  ;; (defhydra hydra-u (evil-normal-state-map "u")
  ;;   ("SPC" (lambda () (interactive) (my-mark-move)))
  ;;   )
  (defhydra hydra-scroll (my-window-map "u")
    ("n" (lambda () (interactive) (scroll-up)))
    ("p" (lambda () (interactive) (scroll-down)))
    ("g" nil "leave")
    )
  ;; (defhydra hydra-ivy (ivy-mode-map "SPC")
  ;;   ("n" (lambda () (interactive) (next-line)))
  ;;   ("g" nil "leave")
  ;;   )
  )

(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode)
  ;; :after ivy
  :config
  (message ":config which-key")
  (which-key-mode t)
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
  ;; (use-package modern-cpp-font-lock
  ;;   :ensure t)
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
  (evil-define-key 'normal python-mode-map (kbd "C-j") 'my-python-run)

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

  (evil-define-key 'normal python-mode-map (kbd "C-S-j")
    'my-python-async-shell-command)
  )

(use-package elisp-format
  :ensure t
  :commands (elisp-format-region)
  :config
  (message ":config elisp-format")
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (message ":config: markdown-mode")
  )

;; (use-package flymd
;;   :ensure t
;;   :config
;;   (message ":config flymd")
;;   )

;; (use-package livedown
;;   :ensure t
;;   :config
;;   (message ":config livedown")
;;   )

;; (use-package markdown-preview-mode
;;   :ensure t
;;   :config
;;   (message ":config markdown-preview-mode")
;;   )

(use-package realgud
  :ensure t
  ;; :defer t
  :commands (realgud:pdb realgud:gdb)
  :custom-face
  (realgud-bp-line-enabled-face ((t (:underline "red"))))
  :config
  (message ":config realgud")

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
        (other-window 1)
        )))

  (define-key realgud:shortkey-mode-map (kbd "p") 'my-gdb-print)
  )

(use-package lsp-mode
  :ensure t
  :hook
  (c++-mode . lsp)
  :config
  (message ":config lsp-mode")
  ;; (require 'lsp-clients)
  ;; (setq lsp-auto-guess-root t)
  ;; (setq lsp-prefer-flymake 'flymake)
  ;; (lsp-prefer-flymake 'flymake)

  (use-package lsp-ui
    :ensure t
    :config
    (message ":config lsp-ui")
    )
  )

(use-package helm-make
  :ensure t
  :commands (helm-make)
  :config
  (message ":config helm-make")
  ;; '(helm-make-completion-method (quote ivy))
  (setq helm-make-completion-method 'ivy))

(use-package highlight-indent-guides
  :ensure t
  :after ivy
  ;; :defer t
  ;; :hook
  ;; (prog-mode . highlight-indent-guides-mode)
  :config
  (message ":config highlight-indent-guides")
  (setq highlight-indent-guides-method 'character)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Edit

;; Windows IME
(when (eq system-type 'windows-nt)
  (setq default-input-method "W32-IME")
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (w32-ime-initialize)
  )

(use-package yasnippet
  :ensure t
  :hook
  ((python-mode c++-mode c-mode) . yas-minor-mode)
  :config
  (message ":config yasnippet")
  (yas-reload-all)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand))

(use-package git-gutter
  :ensure t
  :after ivy
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

(use-package rainbow-delimiters
  :ensure t
  ;; :after ivy
  ;; :defer t
  :hook
  ((emacs-lisp-mode c-mode c++-mode) . rainbow-delimiters-mode)
  :config
  (message ":config rainbow-delimiters")
  (rainbow-delimiters-mode t)
  ;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#9a4040")
  ;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#ff5e5e")
  ;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#ffaa77")
  ;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#dddd77")
  ;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#80ee80")
  ;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#66bbff")
  ;; (set-face-foreground 'rainbow-delimiters-depth-7-face "#da6bda")
  ;; (set-face-foreground 'rainbow-delimiters-depth-8-face "#afafaf")
  ;; (set-face-foreground 'rainbow-delimiters-depth-9-face "#f0f0f0")
  )

(use-package hl-todo
  :ensure t
  :after ivy
  :custom-face
  (hl-todo ((t (:inherit nil :foreground "#ff6c6b" :box 1 :weight bold))))
  :config
  (message ":config hl-todo")
  (global-hl-todo-mode t)
  )

;; (use-package flymake
;;   :ensure t
;;   :defer t
;;   :config
;;   (message ":config flymake"))

;; (use-package flymake-diagnostic-at-point
;;   :ensure t
;;   :after flymake
;;   :config
;;   (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
;;   )

;; (use-package flycheck
;;   :ensure t
;;   :hook
;;   ;; (after-init . global-flycheck-mode)
;;   (c++-mode . flycheck-mode)
;;   :config
;;   (message ":config flycheck")
;;   )

;; (use-package flycheck-posframe
;;   :ensure t
;;   :after flycheck
;;   :config
;;   (message ":config flycheck-posframe")
;;   (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
;;   )

(use-package anzu
  :ensure t
  :after ivy
  :config
  (message ":config anzu")
  (global-anzu-mode t)
  (setq anzu-search-threshold 1000)
  )

;; (use-package origami
;;   :ensure t
;;   :config
;;   (message ":config origami")
;;   )

(add-hook
 'after-init-hook
 '(lambda ()

    ;; NOTE There are 3 type of backup files for a editing file `aaa.txt`.
    ;; 1. `aaa.txt~`: backup file (for before editing state)
    ;; 2. `#aaa.txt#`: auto-save file (for emacs abnormally termination)
    ;; 3. `.#aaa.txt`: lock file (for prohibition of simultaneous editing)

    ;; 1. backup file: aaa.txt~
    (setq version-control t)      ;; version number for backup files
    (setq kept-new-versions 3)    ;; number of retention for new versions
    (setq kept-old-versions 1)    ;; number of retention for old versions
    (setq delete-old-versions t)  ;; delete out-of-range backup files
    (setq backup-directory-alist
          (cons
           (cons ".*" (concat (file-name-directory user-init-file) "bkup/bkup"))
           backup-directory-alist))

    ;; 2. auto-save file: #aaa.txt#
    (setq backup-inhibited nil)
    (setq delete-auto-save-files nil)
    (setq auto-save-timeout 3)     ;; sec
    (setq auto-save-interval 100)  ;; keystroke
    (let ((autosave-dir (concat (file-name-directory user-init-file) "bkup/autosave/")))
      (unless (file-exists-p autosave-dir)
        (make-directory autosave-dir :parents)
        ))
    (setq auto-save-file-name-transforms
          `((".*" ,(concat (file-name-directory user-init-file) "bkup/autosave/") t)))

    ;; 3. lock file: .#aaa.txt
    (setq create-lockfiles nil)
    ))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Other


(add-hook
 'after-init-hook
 ;; 'emacs-startup-hook
 '(lambda ()
    (column-number-mode t)
    (setq inhibit-startup-message t)
    ;; (setq frame-title-format
    ;;       '("emacs " emacs-version (buffer-file-name " - %f")))
    (setq frame-title-format '("emacs " emacs-version))
    ;; NOTE Doom modeline background color is `#373B47`. So if you want to set
    ;; up title bar like doom modeline, you should set by mannually outside
    ;; emacs.

    ;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    ;; (add-to-list 'default-frame-alist '(ns-appearance . red))

    (set-frame-parameter nil 'alpha 99)
    (show-paren-mode t)
    (electric-pair-mode 1)
    ;; (setq scroll-step 1)
    (save-place-mode 1)
    (setq scroll-conservatively 10000)
    (setq scroll-margin 1)
    (setq require-final-newline t)
    (setq scroll-preserve-screen-position t)
    (setq redisplay-dont-pause t)
    (fset 'yes-or-no-p 'y-or-n-p)
    ;; (set-frame-font "Migu 1M-12:antialias=standard")
    (when (eq system-type 'windows-nt)
      (set-frame-font "Consolas-11.5")
      (set-face-attribute 'default nil :height 110)
      )
    (when (eq system-type 'gnu/linux)
      (set-frame-font "Migu 1M-12:antialias=standard")
      )
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

    ;; Suppress warning: ad-handle-definition: ‘~’ got redefined
    (setq ad-redefinition-action 'accept)
    ))

;; (add-hook
;;  'emacs-startup-hook
;;  '(lambda ()
;;     (when (eq system-type 'windows-nt)
;;       (toggle-frame-fullscreen)
;;       )
;;     ))

;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; @ auto
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" default)))
 '(package-selected-packages
   (quote
    (elisp-format yasnippet which-key use-package realgud rainbow-delimiters pt neotree minimap lsp-ui ivy-rich imenu-list hydra hl-todo highlight-indent-guides hide-mode-line helm-make git-gutter evil-magit evil-collection doom-themes doom-modeline counsel company clang-format blacken beacon anzu all-the-icons-ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added ((t (:background "#50fa7b"))))
 '(git-gutter:deleted ((t (:background "#ff79c6"))))
 '(git-gutter:modified ((t (:background "#f1fa8c"))))
 '(hl-todo ((t (:inherit nil :foreground "#ff6c6b" :box 1 :weight bold)))))
