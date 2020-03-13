;; TODO set-mark-command-repeat-pop の振る舞いを変更 (my-space-map ?)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Init

(prefer-coding-system 'utf-8-unix)
;; (setq default-process-coding-system '(utf-8-unix . cp932))
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

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
  (set-face-background 'whitespace-trailing "#222222")
  )

(use-package beacon
  :ensure t
  ;; :custom
  ;; (beacon-color "yellow")
  ;; (beacon-color "orange")
  ;; (beacon-color "#00bfff")
  ;; (beacon-color "#51afef")
  :config
  (message ":config beacon")
  (when (eq system-type 'windows-nt)
    ;; (setq beacon-color "#00bfff"))
    (setq beacon-color "#51afee")
    )

  (when (eq system-type 'gnu/linux)
    (setq beacon-color "#bd93f8")
    ;; (setq beacon-color "#9400d3")
    ;; (setq beacon-color "#a020f0")
    )

  (beacon-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :hook
  (prog-mode . highlight-indent-guides-mode)
  ;; :hook
  ;; ((python-mode c++-mode lisp-mode emacs-lisp-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  ;; (highlight-indent-guides-method 'fill)
  (highlight-indent-guides-method 'column)
  (highlight-indent-guides-auto-enabled t)
  ;; (highlight-indent-guides-responsive t)
  ;; (highlight-indent-guides-method 'character)
  :config
  (message ":config highlight-indent-guides")
  (setq highlight-indent-guides-auto-odd-face-perc 3)
  (setq highlight-indent-guides-auto-even-face-perc 3)
  ;; (setq highlight-indent-guides-method 'fill)
  ;; (highlight-indent-guides-mode t)
  )

;; (use-package yascroll
;;   :ensure t
;;   :after ivy
;;   :custom-face
;;   (yascroll:thumb-fringe ((t (:background "#565761" :foreground "#565761"))))
;;   :config
;;   (message ":config yascroll")
;;   (global-yascroll-bar-mode t)
;;   )

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
  ;; (define-key evil-normal-state-map (kbd "M-x") 'helm-M-x)
  (define-key evil-normal-state-map (kbd "J") 'nil)
  (define-key evil-normal-state-map (kbd "K") 'nil)
  (define-key evil-normal-state-map (kbd "M-p")
    '(lambda () (interactive) (evil-scroll-line-down 5)))
  (define-key evil-normal-state-map (kbd "M-n")
    '(lambda () (interactive) (evil-scroll-line-up 5)))
  ;; (define-key evil-normal-state-map (kbd "s") 'swiper-helm)
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
  ;; TODO
  (define-key evil-normal-state-map (kbd "M")
    '(lambda ()
       (interactive)
       (push-mark)
       (search-forward-regexp "[^ \t\n]")
       (backward-char 1)
       (activate-mark)
       ))
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
      (evil-force-normal-state)
      ))
  (define-key evil-normal-state-map (kbd "`") 'my-cd-current-file-directory)

  ;; ;; evil-insert-state-map
  ;; (define-key evil-insert-state-map (kbd "M-x") 'helm-M-x)
  (define-key evil-insert-state-map (kbd "M-h") 'backward-kill-word)
  (define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
  (define-key evil-insert-state-map (kbd "C-p") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-n") 'next-line)
  (define-key evil-insert-state-map (kbd "C-k") 'kill-line)
  (define-key evil-insert-state-map (kbd "C-w") 'kill-region)
  (define-key evil-insert-state-map (kbd "C-y") 'yank)
  ;; (define-key evil-insert-state-map (kbd "M-y") 'helm-show-kill-ring)
  (define-key evil-insert-state-map (kbd "C-S-p")
    '(lambda () (interactive) (previous-line 5)))
  (define-key evil-insert-state-map (kbd "C-S-n")
    '(lambda () (interactive) (next-line 5)))
  (define-key evil-insert-state-map (kbd "C-S-b")
    '(lambda () (interactive) (backward-char 5)))
  (define-key evil-insert-state-map (kbd "C-S-f")
    '(lambda () (interactive) (forward-char 5)))
  (define-key evil-insert-state-map (kbd "M-p")
    '(lambda () (interactive) (evil-scroll-line-down 5)))
  (define-key evil-insert-state-map (kbd "M-n")
    '(lambda () (interactive) (evil-scroll-line-up 5)))

  ;; evil-motion-state-map
  (define-key evil-motion-state-map (kbd "SPC") 'my-space-map)
  ;; (define-key evil-motion-state-map (kbd "<tab>") nil)  ; TODO
  (define-key evil-motion-state-map (kbd "J")
    '(lambda () (interactive) (next-line 5)))
  (define-key evil-motion-state-map (kbd "K")
    '(lambda () (interactive) (previous-line 5)))

  ;; ;; evil-visual-state-map
  ;; (define-key evil-visual-state-map (kbd "J")
  ;;   '(lambda () (interactive) (evil-next-line 5)))
  ;; (define-key evil-visual-state-map (kbd "K")
  ;;   '(lambda () (interactive) (evil-previous-line 5)))

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

  ;; my-space-map
  (define-prefix-command 'my-space-map)
  (define-key evil-normal-state-map (kbd "SPC") 'my-space-map)
  (define-key my-space-map (kbd "b") 'ivy-switch-buffer)
  ;; (define-key my-space-map (kbd "b") 'helm-mini)
  (define-key my-space-map (kbd "SPC") 'counsel-M-x)
  ;; (define-key my-space-map (kbd "SPC") 'helm-M-x)
  (define-key my-space-map (kbd "f") 'counsel-find-file)
  ;; (define-key my-space-map (kbd "f") 'helm-find-files)
  (define-key my-space-map (kbd "rr") 'counsel-recentf)
  (define-key my-space-map (kbd "/") 'swiper)
  ;; (define-key my-space-map (kbd "l") 'recenter-top-bottom)
  ;; (define-key my-space-map (kbd "g") 'evil-force-normal-state)
  (define-key my-space-map (kbd "gm") 'magit-status)
  (define-key my-space-map (kbd "gg") 'git-gutter)
  (define-key my-space-map (kbd "i") 'imenu-list-smart-toggle) ; TODO
  (define-key my-space-map (kbd "dd") '(lambda ()
                                        (interactive)
                                        (kill-buffer (current-buffer))
                                        ))
  (define-key my-space-map (kbd "o") '(lambda ()
                                        (interactive)
                                        (other-window 1)
                                        (evil-force-normal-state)
                                        ))
  ;; (define-key my-space-map (kbd "ns") 'neotree-show)
  ;; (define-key my-space-map (kbd "nh") 'neotree-hide)
  ;; (define-key my-space-map (kbd "nt") 'neotree-toggle)
  ;; (define-key my-space-map (kbd "nr") 'neotree-refresh)
  (define-key my-space-map (kbd "n") 'dumb-jump-go)
  (define-key my-space-map (kbd "N") 'dumb-jump-back)
  (define-key my-space-map (kbd "cc") 'compile)
  (define-key my-space-map (kbd "cm") 'helm-make)
  (define-key my-space-map (kbd "rg") 'realgud:gdb)
  (define-key my-space-map (kbd "rp") 'realgud:pdb)
  (define-key my-space-map (kbd "@") 'my-cd-current-file-directory)
  (define-key my-space-map (kbd "tf") 'toggle-frame-fullscreen)
  (define-key my-space-map (kbd "uo") 'toggle-frame-fullscreen)
  ;; (define-key my-space-map (kbd "J") 'smooth-scroll/scroll-up)
  (define-key my-space-map (kbd "dk") 'describe-key)
  (define-key my-space-map (kbd "dv") 'describe-variable)
  (define-key my-space-map (kbd "df") 'describe-function)
  (define-key my-space-map (kbd "dF") 'describe-face)
  (define-key my-space-map (kbd "dm") 'describe-mode)
  (define-key my-space-map (kbd "dt") 'describe-theme)
  ;; (define-key my-sapce-map (kbd "crg") 'realgud:gdb)
  ;; (define-key my-sapce-map (kbd "crp") 'realgud:pdb)

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

;; (use-package evil-collection
;;   :ensure t
;;   ;; :after evil
;;   :after ivy
;;   :config
;;   (message ":config evil-collection")
;;   (evil-collection-init)
;;   )

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

;; (use-package helm
;;   :ensure t
;;   :config
;;   (message ":config helm")

;;   (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

;;   (define-key helm-map (kbd "C-h") 'delete-backward-char)
;;   ;; TODO M-h

;;   ;; (setq helm-split-window-in-side-p t)
;;   (add-to-list 'display-buffer-alist
;;                `(,(rx bos "*helm" (* not-newline) "*" eos)
;;                  (display-buffer-in-side-window)
;;                  (inhibit-same-window . t)
;;                  (window-height . 0.5)))
;;   )

;; (use-package swiper-helm
;;   :ensure t
;;   :config
;;   (message ":config swiper-helm")

;;   (add-to-list 'display-buffer-alist
;;                `(,(rx bos "*swiper" (* not-newline) "*" eos)
;;                  (display-buffer-in-side-window)
;;                  (inhibit-same-window . t)
;;                  (window-height . 0.5)))
;;   ;; (setq swiper-helm-display-function 'helm-default-display-buffer)
;;   )

;; (use-package helm-swoop
;;   :ensure t
;;   :config
;;   (message ":config helm-swoop")
;;   )

(use-package ivy
  :ensure t
  :defer
  ;; :custom
  ;; (ivy-format-function 'ivy-format-function-arrow)
  :config
  (message ":config ivy")
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) ")

  (setq ivy-height-alist
        '((t lambda (_caller)
             (/ (frame-height) 2))))

  ;; (add-to-list 'ivy-height-alist
  ;;              (cons 'counsel-find-file
  ;;                    (lambda (_caller)
  ;;                      (/ (frame-height) 2))))

  ;; (define-key counsel-find-file-map (kbd "C-x C-f")
  ;;   (lambda ()
  ;;     (interactive)
  ;;     (ivy-set-action
  ;;      (lambda (_x)
  ;;        (let ((completing-read-function 'completing-read-default))
  ;;          (call-interactively 'find-file))))
  ;;     (ivy-done)))

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
  )

(use-package counsel
  :ensure t
  :after ivy
  :config
  (message ":config counsel")
  (counsel-mode 1)
  (define-key counsel-find-file-map (kbd "C-l") 'backward-kill-word)
  )

(use-package swiper
  :ensure t
  :after ivy
  :config
  (message ":config swiper")
  ;; :bind (("C-s" . swiper)
  ;;        ("C-r" . swiper))
  ;; (defvar swiper-include-line-number-in-search t) ;; line-number search
  )

;; (use-package migemo
;;   :ensure t
;;   :config
;;   ;; C/Migemo を使う場合は次のような設定を .emacs に加えます．
;;   (setq migemo-command "cmigemo")
;;   (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;;   ;; (setq migemo-dictionary "/usr/local/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")  ;; 各自の辞書の在り処を指示
;;   (setq migemo-user-dictionary nil)
;;   (setq migemo-regex-dictionary nil)
;;   ;; charset encoding
;;   (setq migemo-coding-system 'utf-8-unix)
;;   )

;; (use-package avy-migemo
;;   :ensure t
;;   :config
;;   (avy-migemo-mode 1)
;;   (setq avy-timeout-seconds nil)
;;   (require 'avy-migemo-e.g.swiper)
;;   (global-set-key (kbd "C-M-;") 'avy-migemo-goto-char-timer)
;;   ;;  (global-set-key (kbd "M-g m m") 'avy-migemo-mode)
;;   )

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
    ;; ("h" (lambda () (interactive) (evil-backward-char 5)))
    ;; ("l" (lambda () (interactive) (evil-forward-char 5)))
    ("l" (lambda () (interactive) (recenter-top-bottom)))
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

;; (use-package neotree
;;   :ensure t
;;   :defer
;;   ;; :commands (neotree-show)
;;   ;; :after
;;   ;; projectile
;;   ;; :hook
;;   ;; (ivy-mode . neotree-show)
;;   ;; (find-file . neotree-refresh)
;;   ;; :commands
;;   ;; (neotree-show neotree-hide neotree-dir neotree-find)
;;   :config
;;   (message ":config neotree")
;;   (add-hook 'neotree-mode-hook '(lambda ()
;;                                   (display-line-numbers-mode 0)
;;                                   (text-scale-decrease 1)
;;                                   ))
;;   (setq neo-show-hidden-files t)
;;   (setq neo-theme 'icons)
;;   (setq neo-window-fixed-size nil)
;;   (setq neo-window-width 20)
;;   ;; (neo-theme 'nerd2)
;;   )

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

(use-package google-translate
  :ensure t
  :after ivy
  :config
  (message ":config google-translate")
  (defvar google-translate-english-chars "[:ascii:]’“”–"
    "When these characters are included, it is considered as English")
  (defun google-auto-translate (&optional string)
    "Google translates the region or the current sentence by automatic language detection."
    (interactive)
    (setq string
          (cond ((stringp string) string)
                (current-prefix-arg
                 (read-string "Google Translate: "))
                ((use-region-p)
                 (buffer-substring (region-beginning) (region-end)))
                (t
                 (save-excursion
                   (let (s)
                     (forward-char 1)
                     (backward-sentence)
                     (setq s (point))
                     (forward-sentence)
                     (buffer-substring s (point)))))))
    (let* ((asciip (string-match
                    (format "\\`[%s]+\\'" google-translate-english-chars)
                    string)))
      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
       (if asciip "en" "ja")
       (if asciip "ja" "en")
       string)))

  (define-key evil-normal-state-map (kbd "T") 'google-auto-translate)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Programming

(use-package magit
  :ensure t
  ;; :defer t                                ; TODO
  :commands (magit magit-status)
  :config
  (message ":config magit")
  (define-key magit-status-mode-map (kbd "SPC") nil)
  (define-key magit-log-mode-map (kbd "SPC") nil)
  (define-key magit-diff-mode-map (kbd "SPC") nil)
  )

;; (use-package magithub
;;   :ensure t
;;   :after magit
;;   :config
;;   (message ":config magithub")
;;   (magithub-feature-autoinject t)
;;   (setq magithub-clone-default-directory "~/github")
;;   )

(use-package monky
  :ensure t
  :config
  (message ":config monky")
  )

(use-package imenu-list
  :ensure t
  :defer t
  ;; :bind
  ;; ("<f10>" . imenu-list-smart-toggle)
  ;; TODO Consider bind
  :config
  (message ":config imenu-list")
  )

(use-package f90
  :mode (("\\.f90" . f90-mode))
  :config
  (message ":config f90")

  (add-hook
   'f90-mode-hook
   '(lambda ()
      (set (make-local-variable 'compile-command)
           (format "gfortran %s" (file-name-nondirectory buffer-file-name)))))
  )

(use-package cc-mode
  :mode (("\\.cpp" . c++-mode)
         ("\\.cc" . c++-mode)
         ("\\.smp" . c++-mode))
  :config
  (message ":config cc-mode")

  ;; Compile command
  (add-hook
   'c++-mode-hook
   (lambda ()
     (set (make-local-variable 'compile-command)
          (format "g++ -Wall -Wextra -std=c++14 %s"
                  (file-name-nondirectory buffer-file-name)))))

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
         ))
    (define-key evil-normal-state-map (kbd "F")
      '(lambda ()
         (interactive)
         (clang-format-buffer)
         (save-buffer)
         (message "\"clang-format-buffer\" and \"save-buffer\"")
         ))
    )

  ;; (use-package clang-format+
  ;;   :ensure t
  ;;   :config
  ;;   (message ":config clang-format+")
  ;;   )

  ;; (use-package modern-cpp-font-lock
  ;;   :ensure t)
  )

(use-package cmake-mode
  :ensure t
  :mode (("CMakeLists.txt" . cmake-mode))
  :config
  (message ":config cmake-mode")

  (defun my-cmake-run ()
    (interactive)
    (let ((command (concat "cmake -P " (file-name-base) ".cmake")))
      (save-buffer)
      (async-shell-command command)
      ))
  (evil-define-key 'normal cmake-mode-map (kbd "C-j") 'my-cmake-run)

  )

(use-package csv-mode
  :ensure t
  :mode (("\\.csv" . csv-mode))
  :config
  (message ":config csv-mode")
  )

(use-package python
  :defer t
  :mode (("\\.py" . python-mode))
  :config
  (message ":config python")

  ;; (use-package blacken
  ;;   :ensure t
  ;;   :hook
  ;;   (python-mode . blacken-mode)
  ;;   :config
  ;;   (message ":config blacken")
  ;;   ;; (blacken-mode t)
  ;;   )

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

  (evil-define-key 'normal python-mode-map (kbd "F")
    '(lambda ()
       (interactive)
       (blacken-buffer)
       (save-buffer)
       (message "\"blacken-buffer\" and \"save-buffer\"")
       ))
  )

(use-package ess
  :ensure t
  :mode (("\\.R" . ess-r-mode))
  :config
  (message ":config ess")

  (defun my-r-run ()
    (interactive)
    (let ((command (concat "Rscript " (file-name-base) ".R")))
      (save-buffer)
      (async-shell-command command)
      ))
  (evil-define-key 'normal ess-r-mode-map (kbd "C-j") 'my-r-run)
  )

(use-package rust-mode
  :ensure t
  :mode ("\\.rs" . rust-mode)
  :config
  (message ":config rust-mode")
  (setq rust-format-on-save t)

  ;; Compile command
  (add-hook
   'rust-mode-hook
   (lambda ()
     (set (make-local-variable 'compile-command)
          (format "rustc %s -o a.exe"
                  (file-name-nondirectory buffer-file-name)))))

  )

(use-package go-mode
  :ensure t
  :mode ("\\.go" . go-mode)
  :config
  (message ":config go-mode")

  ;; Compile command
  (add-hook
   'go-mode-hook
   (lambda ()
     (set (make-local-variable 'compile-command)
          (format "go build %s"
                  (file-name-nondirectory buffer-file-name)))
     (define-key evil-normal-state-map (kbd "F")
       '(lambda ()
          (interactive)
          (gofmt)
          (save-buffer)
          (message "\"gofmt\" and \"save-buffer\"")
          ))
     ))
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
  ;; :init (setq markdown-command "multimarkdown")
  :config
  (message ":config: markdown-mode")
  )

(use-package graphviz-dot-mode
  :ensure t
  :mode (("\\.dot" . graphviz-dot-mode))
  :config
  (message ":config graphviz-dot-mode")

  (add-hook
   'graphviz-dot-mode-hook
   '(lambda ()
      (set (make-local-variable 'compile-command)
           (format "dot -Tsvg %s -o %s.svg"
                   (file-name-nondirectory buffer-file-name)
                   (file-name-base)
                   ))))
  )

(use-package yatex
  :ensure t
  :mode (("\\.tex" . yatex-mode))
  :config
  (message ":config yatex")

  (defun my-typeset-and-dvi2pdf ()
    (interactive)
    (let ((mycommand
           (format "platex.exe %s.tex && dvipdfmx.exe %s.dvi"
                   (file-name-base) (file-name-base))))
      (save-buffer)
      (async-shell-command mycommand)
      ))

  (defun my-typeset ()
    (interactive)
    (let ((cmd (format "platex.exe %s.tex && dvipdfmx.exe %s.dvi"
                       (file-name-base) (file-name-base))))
      (save-excursion
        (other-window 1)
        (insert cmd)
        (other-window 1)
        )
      )
    )

  (defun my-display-pdf ()
    (interactive)
    (let* ((mycommand
            (format "sumatrapdf.exe %s.pdf" (file-name-base))))
      (async-shell-command mycommand)
      ;; (delete-other-windows)
      ))

  (define-key evil-normal-state-map (kbd "C-j") 'my-typeset-and-dvi2pdf)
  (define-key evil-normal-state-map (kbd "C-S-j") 'my-display-pdf)

  (defun input-label()
    (interactive)
    (insert (format-time-string "%Y%m%d%H%M%S" (current-time))))
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
  :commands (realgud:pdb realgud:gdb)
  :custom-face
  (realgud-bp-line-enabled-face ((t (:underline "red"))))
  :config
  (message ":config realgud")
  (setq realgud-safe-mode nil)

  (defun my-realgud-print ()
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

  (define-key realgud:shortkey-mode-map (kbd "p") 'my-realgud-print)
  )

;; (use-package lsp-mode
;;   :ensure t
;;   :hook
;;   (c++-mode . lsp)
;;   :config
;;   (message ":config lsp-mode")
;;   ;; (require 'lsp-clients)
;;   ;; (setq lsp-auto-guess-root t)
;;   ;; (setq lsp-prefer-flymake 'flymake)
;;   ;; (lsp-prefer-flymake 'flymake)

;;   (use-package lsp-ui
;;     :ensure t
;;     :config
;;     (message ":config lsp-ui")
;;     )
;;   )

(use-package helm-make
  :ensure t
  :commands (helm-make)
  :config
  (message ":config helm-make")
  ;; '(helm-make-completion-method (quote ivy))
  (setq helm-make-completion-method 'ivy))

;; (use-package highlight-indent-guides
;;   :ensure t
;;   :after ivy
;;   ;; :defer t
;;   ;; :hook
;;   ;; (prog-mode . highlight-indent-guides-mode)
;;   :config
;;   (message ":config highlight-indent-guides")
;;   (setq highlight-indent-guides-method 'character)
;;   )

(use-package dumb-jump
  :ensure t
  :config
  (message ":config dumb-jump")
  (setq dumb-jump-selector 'ivy)

  ;; (define-key evil-normal-state-map (kbd "") 'dumb-jump-go)
  ;; (define-key evil-normal-state-map (kbd "") 'dumb-jump-back)
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


(when (eq system-type 'gnu/linux)
  (use-package ddskk
    :ensure t
    :defer t
    :bind (("C-\\" . skk-mode))
    :init
    (message ":init ddskk")
    (setq skk-kutouten-type 'en)
    (define-key evil-insert-state-map (kbd "<escape>")
      '(lambda ()
         (interactive)
         (skk-mode -1)
         (evil-force-normal-state)
         ))
    (define-key evil-normal-state-map (kbd "<escape>")
      '(lambda ()
         (interactive)
         (skk-mode -1)
         (evil-force-normal-state)
         ))
    ))

(use-package yasnippet
  :ensure t
  :hook
  ;; ((python-mode c++-mode c-mode) . yas-minor-mode)
  ((prog-mode yatex-mode) . yas-minor-mode)
  :config
  (message ":config yasnippet")
  (yas-reload-all)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
  )

(use-package git-gutter
  :ensure t
  :after ivy
  :custom
  (git-gutter:modified-sign "~")
  (git-gutter:added-sign    "+")
  (git-gutter:deleted-sign  "-")
  :custom-face
  (git-gutter:modified ((t (:background "#f1fa8c" :foreground "black"))))
  (git-gutter:added    ((t (:background "#50fa7b" :foreground "black"))))
  (git-gutter:deleted  ((t (:background "#ff79c6" :foreground "black"))))
  :config
  (message ":config git-gutter")
  (global-git-gutter-mode +1)
  )

(use-package smooth-scroll
  :ensure t
  :config
  (message ":config smooth-scroll")
  (smooth-scroll-mode t)
  )

(use-package pt
  :ensure t
  :config
  (message ":config pt")
  (define-key evil-normal-state-map (kbd "C-S-g") 'pt-regexp)
  )

(use-package ag
  :ensure t
  :config
  (message ":config ag")
  )

(use-package highlight-symbol
  :ensure t
  :after ivy
  :hook
  (prog-mode . highlight-symbol-mode)
  :config
  (message ":config highlight-symbol")

  ;; Key binding
  ;; (define-key evil-normal-state-map (kbd "n") 'highlight-symbol-next)
  ;; (define-key evil-normal-state-map (kbd "p") 'highlight-symbol-prev)

  )

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

(use-package rainbow-mode
  :ensure t
  :hook
  ((emacs-lisp-mode . rainbow-mode))
  :config
  (message ":config rainbow-mode")
  ;; (rainbow-mode t)
  )

(use-package hl-todo
  :ensure t
  :after ivy
  :custom-face
  (hl-todo ((t (:inherit nil :foreground "#ff6c6b"
                         ;; :box 1
                         :weight bold))))
  :config
  (message ":config hl-todo")
  (global-hl-todo-mode t)
  )

(use-package flymake
  :ensure t
  :defer t
  :hook
  (python-mode . flymake-mode)
  :config
  (message ":config flymake")

  ;; For Python
  (add-hook 'find-file-hook 'flymake-find-file-hook) ; ?
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes"  (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init))

  )

(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :custom
  ;; (flymake-diagnostic-at-point-timer-delay 0.1)
  (flymake-diagnostic-at-point-error-prefix "▲ ")
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
  )

;; (use-package flycheck
;;   :ensure t
;;   :hook
;;   ;; (after-init . global-flycheck-mode)
;;   (c++-mode . flycheck-mode)
;;   (python-mode . flycheck-mode)
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

    (when (eq system-type 'windows-nt)
      (set-frame-font "Migu 1M-12:antialias=standard")

      ;; For surface
      (when (equal system-name "DESKTOP-U491J4T")
        (set-frame-font "Migu 1M-11:antialias=standard"))
      )

    (when (eq system-type 'gnu/linux)
      (set-frame-font "Migu 1M-12:antialias=standard"))

    ;; Distinguish "C-i" and "TAB"
    (define-key input-decode-map "\C-i" [C-i])

    ;; Key binding
    (define-key global-map (kbd "C-h") (kbd "DEL"))
    (define-key global-map (kbd "C-<tab>") 'dabbrev-expand)
    (define-key global-map (kbd "<C-i>") 'dabbrev-expand)
    (global-set-key (kbd "C-8") 'start-kbd-macro)
    (global-set-key (kbd "C-9") 'end-kbd-macro)
    (global-set-key (kbd "C-0") 'call-last-kbd-macro)

    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 4)
    (setq set-mark-command-repeat-pop t)

    ;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
    (defun set-whitespace-deleter ()
      (unless (eq major-mode 'fundamental-mode)
        (add-hook 'before-save-hook
                  'delete-trailing-whitespace nil t)))
    (add-hook 'after-change-major-mode-hook 'set-whitespace-deleter)

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
 '(package-selected-packages
   (quote
    (highlight-symbol clang-format+ monky yasnippet which-key volatile-highlights use-package swiper-helm smooth-scroll realgud rainbow-mode rainbow-delimiters pt powerline origami nyan-mode neotree modalka minimap lsp-ui ivy-rich imenu-list hydra hl-todo highlight-indent-guides hide-mode-line hemisu-theme helm-make gruvbox-theme graphviz-dot-mode git-gutter ghub+ flymd flymake-diagnostic-at-point flycheck-posframe fill-column-indicator evil-magit evil-collection elisp-format doom-themes doom-modeline dashboard counsel company-box cmake-mode clang-format blacken beacon atom-dark-theme anzu amx all-the-icons-ivy ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added ((t (:background "#50fa7b" :foreground "black"))))
 '(git-gutter:deleted ((t (:background "#ff79c6" :foreground "black"))))
 '(git-gutter:modified ((t (:background "#f1fa8c" :foreground "black"))))
 '(hl-todo ((t (:inherit nil :foreground "#ff6c6b" :weight bold))))
 '(realgud-bp-line-enabled-face ((t (:underline "red")))))
(put 'upcase-region 'disabled nil)
