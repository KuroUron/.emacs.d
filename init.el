;; TODO set-mark-command-repeat-pop の振る舞いを変更 (my-space-map ?)

;; カスタマイズの参考ページ
;;
;; - [A Life Configuring Emacs](https://alhassy.github.io/init/)
;; - [Emacsモダン化計画 -かわEmacs編-](https://qiita.com/Ladicle/items/feb5f9dce9adf89652caf)
;; - [無名 λ](https://zenn.dev/lambdagonbei)
;; - [ぐるっとぐりっど: My Emacs Config](https://www.grugrut.net/posts/my-emacs-init-el/)
;; - [Org-Roam-UI On GNU/Emacs](https://www.youtube.com/watch?v=e-SjhYZjIO8)
;; - [suprhst/dotfiles](https://github.com/suprhst/dotfiles/tree/main/dotfiles-ext/emacs.d)
;; - [日々、とんは語る。](https://blog.tomoya.dev/)

;; Elisp の勉強
;;
;; - [Adding A New Language to Emacs](https://www.wilfred.me.uk/blog/2015/03/19/adding-a-new-language-to-emacs/)

;; NOTE 2020-04-02: When the migemo fails, reinstall the evil package.

;; NOTE 2020-07-09: Linux 環境で cmigemo を用いる際には
;; `nora/migemo/bin/libmigemo.so.1` を `/usr/lib` にコピーすること．

;; NOTE 2021-11-25: `Failed to verify signature archive-contents.sig:` というエラーが
;; でるときには msys2 の gpg が悪さをしている可能性があるので，
;; 一旦 msys2 へのパスを無くしてからサイド長選すると良い．

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
    ;; (load-theme 'doom-one t)
    (load-theme 'doom-vibrant t)
    ;; (load-theme 'doom-dracula t)
    ;; (load-theme 'doom-ayu-mirage t)
    ;; (load-theme 'doom-challenger-deep t)
    ;; (load-theme 'doom-dark+ t)
    ;; (load-theme 'doom-ephemeral t)
    ;; (load-theme 'doom-gruvbox t)
    ;; (load-theme 'doom-homage-black t)
    ;; (load-theme 'doom-monokai-pro t)
    ;; (load-theme 'doom-moonlight t)
    ;; (load-theme 'doom-nord t)
    ;; (load-theme 'doom-snazzy t)
    ;; (load-theme 'doom-zenburn t)
    ;; (load-theme 'doom-xcode t)
    ;; (load-theme ' t)
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

;; (use-package modus-themes
;;   :ensure t
;;   :config
;;   (message ":config modus-themes")

;;   (setq modus-themes-italic-constructs t
;;         modus-themes-bold-constructs nil
;;         modus-themes-region '(bg-only no-extend)

;;         ;; Options for `modus-themes-syntax' are either nil (the default),
;;         ;; or a list of properties that may include any of those symbols:
;;         ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
;;         modus-themes-syntax '(green-strings)

;;         ;; Options for `modus-themes-mode-line' are either nil, or a list
;;         ;; that can combine any of `3d' OR `moody', `borderless',
;;         ;; `accented'.  The variable's doc string shows all possible
;;         ;; combinations.
;;         modus-themes-mode-line '(moody)

;;         ;; Options for `modus-themes-paren-match' are either nil (the
;;         ;; default), or a list of properties that may include any of those
;;         ;; symbols: `bold', `intense', `underline'
;;         modus-themes-paren-match '(bold intense)

;;         ;; Options for `modus-themes-links' are either nil (the default),
;;         ;; or a list of properties that may include any of those symbols:
;;         ;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
;;         ;; `bold', `italic', `background'
;;         modus-themes-links '(neutral-underline background)

;;         modus-themes-variable-pitch-ui t
;;         modus-themes-variable-pitch-headings t
;;         modus-themes-scale-headings t
;;         modus-themes-scale-1 1.00       ; 1.10
;;         modus-themes-scale-2 1.05       ; 1.15
;;         modus-themes-scale-3 1.10       ; 1.21
;;         modus-themes-scale-4 1.15       ; 1.27
;;         modus-themes-scale-title 1.20   ; 1.33
;;   )

;;   (modus-themes-load-themes)
;;   ;; (modus-themes-load-operandi) ; ライト
;;   (modus-themes-load-vivendi) ; ダーク

;;   ;; (global-set-key (kbd "<f5>") 'modus-themes-toggle) ; テーマの切り替え
;;   )

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

;; (use-package moody
;;   :ensure t
;;   :config
;;   (message ":config moody")
;;   (setq x-underline-at-descent-line t)
;;   (moody-replace-mode-line-buffer-identification)
;;   (moody-replace-vc-mode)

;;   (use-package minions
;;     :ensure t
;;     :config
;;     (message ":config minions")
;;     ;; (setq minions-mode-line-lighter "⚙"
;;     ;;       minions-mode-line-delimiters (cons "" ""))
;;     (setq minions-mode-line-lighter "[+]")
;;     (minions-mode)
;;     )
;;   )

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

;; ;; ヤンクした場合などに編集箇所を強調表示してわかりやすくする
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

;; (use-package beacon
;;   :ensure t
;;   ;; :custom
;;   ;; (beacon-color "yellow")
;;   ;; (beacon-color "orange")
;;   ;; (beacon-color "#00bfff")
;;   ;; (beacon-color "#51afef")
;;   :config
;;   (message ":config beacon")
;;   (when (eq system-type 'windows-nt)
;;     ;; (setq beacon-color "#00bfff"))
;;     (setq beacon-color "#51afee")
;;     )

;;   (when (eq system-type 'gnu/linux)
;;     (setq beacon-color "#bd93f8")
;;     ;; (setq beacon-color "#9400d3")
;;     ;; (setq beacon-color "#a020f0")
;;     )

;;   (beacon-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :hook
  (prog-mode . highlight-indent-guides-mode)
  ;; :hook
  ;; ((python-mode c++-mode lisp-mode emacs-lisp-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  ;; (highlight-indent-guides-method 'fill)

  (highlight-indent-guides-method 'column)

  ;; (highlight-indent-guides-method 'character)
  ;; (highlight-indent-guides-character ?\|)

  ;; (highlight-indent-guides-responsive t)
  ;; (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-auto-enabled nil)

  :config
  (message ":config highlight-indent-guides")
  ;; (setq highlight-indent-guides-auto-odd-face-perc 3)
  ;; (setq highlight-indent-guides-auto-even-face-perc 3)
  ;; (setq highlight-indent-guides-method 'fill)
  ;; (highlight-indent-guides-mode t)

  (set-face-background 'highlight-indent-guides-odd-face "#222528")
  (set-face-background 'highlight-indent-guides-even-face "#282522")
  ;; e.g. "dimgray", "darkgray"

  ;; (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
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

(use-package undo-tree
  :ensure t
  :config
  (message ":config undo-tree")
  (global-undo-tree-mode)
  )

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)       ; for evil-collection
  (setq evil-want-C-u-scroll t)         ; C-u
  :config
  (message ":config evil")
  (evil-mode t)

  ;; デフォルトモードの設定
  ;; cf. https://blog.aaronbieber.com/2016/01/23/living-in-evil.html
  ;; (add-to-list 'evil-emacs-state-modes '<some-mode>)
  ;; (add-to-list 'evil-insert-state-modes '<some-mode>)
  ;; (add-to-list 'evil-visual-state-modes '<some-mode>)
  ;; (add-to-list 'evil-normal-state-modes '<some-mode>)
  (add-to-list 'evil-normal-state-modes 'package-menu-mode)
  (add-to-list 'evil-normal-state-modes 'help-mode)

  ;; (setq evil-normal-state-cursor "dark green")
  ;; (setq evil-insert-state-cursor ("dark red" . 2))

  ;; evil-normal-state-map
  ;; (define-key evil-normal-state-map (kbd "M-x") 'helm-M-x)
  ;; (define-key evil-normal-state-map (kbd "J") 'nil)
  ;; (define-key evil-normal-state-map (kbd "K") 'nil)
  (define-key evil-insert-state-map (kbd "<escape>")
    '(lambda () (interactive)
       ;; shell や scratch では保存しない
       (if (buffer-file-name)
           (progn
             (save-buffer)
             (message "\"save-buffer\"")))
       (evil-normal-state)))
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

  ;; ;; evil-normal-state-map
  (define-key evil-normal-state-map (kbd "C-<tab>") 'tab-next)
  (define-key evil-normal-state-map (kbd "C-o") 'tab-new)

  ;; ;; evil-insert-state-map
  ;; (define-key evil-insert-state-map (kbd "M-x") 'helm-M-x)
  (define-key evil-insert-state-map (kbd "C-<tab>") 'dabbrev-expand)
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
  ;; (define-key evil-insert-state-map (kbd "M-p")
  ;;   '(lambda () (interactive) (evil-scroll-line-down 5)))
  ;; (define-key evil-insert-state-map (kbd "M-n")
  ;;   '(lambda () (interactive) (evil-scroll-line-up 5)))

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

  ;; cf. https://suzuki.tdiary.net/20140806.html
  (defun swap-buffers ()
    "Swapping buffers in two windows"
    (interactive)
    (let ((current-w (frame-selected-window))
          (current-b (window-buffer (frame-selected-window)))
          (other-w (get-lru-window))
          (other-b (window-buffer (get-lru-window))))
      (if (not (one-window-p))
          (progn
            (select-window current-w)
            (switch-to-buffer other-b)
            (select-window other-w)
            (switch-to-buffer current-b)
            ))))

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
  ;; (define-key my-window-map (kbd "uo") 'toggle-frame-fullscreen)
  (define-key my-window-map (kbd "uo") 'swap-buffers)
  )

(use-package evil-collection
  ;; This includs `evil-magit`
  :after magit
  :ensure t
  :config
  (message ":config evil-collection")
  (evil-collection-init)
  )

;; (use-package evil-magit
;;   :after evil-collection
;;   :ensure t
;;   ;; :disabled
;;   :config
;;   (message ":config evil-magit")
;;

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

  ;; <escape> を一回で ivy を抜けられるようにする
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

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

;; (use-package ivy-posframe
;;   :ensure t
;;   :after ivy
;;   :config
;;   (message ":config ivy-posframe")

;;   ;; display at `ivy-posframe-style'
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))

;;   (ivy-posframe-mode 1)
;;   )

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1)
  :config
  (message ":config all-the-icons-ivy-rich")

  ;; Whether display the icons
  (setq all-the-icons-ivy-rich-icon t)

  ;; Whether display the colorful icons.
  ;; It respects `all-the-icons-color-icons'.
  (setq all-the-icons-ivy-rich-color-icon t)

  ;; The icon size
  (setq all-the-icons-ivy-rich-icon-size 1.0)

  ;; Whether support project root
  (setq all-the-icons-ivy-rich-project t)

  ;; Definitions for ivy-rich transformers.
  ;; See `ivy-rich-display-transformers-list' for details."
  all-the-icons-ivy-rich-display-transformers-list

  ;; Slow Rendering
  ;; If you experience a slow down in performance when rendering multiple icons simultaneously,
  ;; you can try setting the following variable
  (setq inhibit-compacting-font-caches t)
  )

;; (use-package all-the-icons-ivy
;;   :ensure t
;;   :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup)
;;   :config
;;   (message ":config all-the-icons-ivy")
;;   )

;; ;; Enable richer annotations using the Marginalia package
;; (use-package marginalia
;;   :ensure t
;;   ;; Either bind `marginalia-cycle` globally or only in the minibuffer
;;   :bind (("M-A" . marginalia-cycle)
;;          :map minibuffer-local-map
;;          ("M-A" . marginalia-cycle))

;;   ;; The :init configuration is always executed (Not lazy!)
;;   :init

;;   ;; Must be in the :init section of use-package such that the mode gets
;;   ;; enabled right away. Note that this forces loading the package.
;;   (marginalia-mode)

;;   :config
;;   (message ":config marginalia")
;;   )

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

;; (use-package prescient
;;   ;; cf. https://github.com/raxod502/prescient.el
;;   ;;  Fast and intuitive frequency-and-recency-based sorting and filtering for Emacs.
;;   :ensure t
;;   :after ivy
;;   :custom (prescient-aggressive-file-save t)
;;   :config
;;   (message ":config prescient")
;;   (prescient-persist-mode 1)
;;   )

;; (use-package ivy-prescient
;;   ;; prescient.el + Ivy
;;   :ensure t
;;   :after prescient
;;   :custom (ivy-prescient-retain-classic-highlighting t)
;;   :config
;;   (message ":config ivy-prescient")
;;   (ivy-prescient-mode 1)
;;   )

(use-package migemo
  ;; cf. https://github.com/koron/cmigemo
  :ensure t
  :config
  (message ":config cmigemo")
  (setq migemo-command
        (concat
         (expand-file-name user-emacs-directory)
         "nora/migemo/bin/"
         (cond
          ((eq system-type 'windows-nt) "cmigemo.exe")
          ((eq system-type 'gnu/linux) "cmigemo.out"))))
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-dictionary
        (concat
         (expand-file-name user-emacs-directory)
         "nora/migemo/dict/utf-8/migemo-dict"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)

  ;; For evil `/?`, redefine `evil-search-function`
  (setq evil-regexp-search nil)
  ;;   (defun evil-search-function (&optional forward regexp-p wrap)
  ;;     "Return a search function.
  ;; If FORWARD is nil, search backward, otherwise forward.
  ;; If REGEXP-P is non-nil, the input is a regular expression.
  ;; If WRAP is non-nil, the search wraps around the top or bottom
  ;; of the buffer."
  ;;     `(lambda (string &optional bound noerror count)
  ;;        (let ((start (point))
  ;;              (search-fun ',(if regexp-p
  ;;                                (if forward
  ;;                                    're-search-forward
  ;;                                  're-search-backward)
  ;;                              (if forward
  ;;                                  'migemo-forward
  ;;                                'migemo-backward)))
  ;;              result)
  ;;          (setq result (funcall search-fun string bound
  ;;                                ,(if wrap t 'noerror) count))
  ;;          (when (and ,wrap (null result))
  ;;            (goto-char ,(if forward '(point-min) '(point-max)))
  ;;            (unwind-protect
  ;;                (setq result (funcall search-fun string bound noerror count))
  ;;              (unless result
  ;;                (goto-char start))))
  ;;          result)))

  (defun evil-search-function (&optional forward regexp-p wrap predicate)
    "Return a search function.
If FORWARD is nil, search backward, otherwise forward.
If REGEXP-P is non-nil, the input is a regular expression.
If WRAP is non-nil, the search wraps around the top or bottom
of the buffer.
If PREDICATE is non-nil, it must be a function accepting two
arguments: the bounds of a match, returning non-nil if that match is
acceptable."
    `(lambda (string &optional bound noerror count)
       (let ((start (point))
             (search-fun ',(if regexp-p
                               (if forward
                                   're-search-forward
                                 're-search-backward)
                             (if forward
                                 'migemo-forward
                               'migemo-backward)))
             result)
         (setq result (evil-search-with-predicate
                       search-fun ,predicate string
                       bound ,(if wrap t 'noerror) count))
         (when (and ,wrap (null result))
           (goto-char ,(if forward '(point-min) '(point-max)))
           (unwind-protect
               (setq result (evil-search-with-predicate
                             search-fun ,predicate string bound noerror count))
             (unless result
               (goto-char start))))
         result)))

  )

;; (use-package avy-migemo
;;   :ensure t
;;   :config
;;   (avy-migemo-mode 1)
;;   ;; (setq avy-timeout-seconds nil)
;;   (require 'avy-migemo-e.g.counsel)
;;   (require 'avy-migemo-e.g.swiper)
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
  (define-key company-active-map (kbd "<tab>") 'yas-expand)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "<tab>") 'yas-expand)
  )

;; (use-package hydra-posframe
;;   :ensure t
;;   :hook (after-init . hydra-posframe-enable)
;;   :config
;;   (message ":config hydra-posframe")
;;   )

(use-package hydra
  :ensure t
  :after ivy
  :config
  (message ":config hydra")

  (defun get-stars (n offset)
    (let ((stars "★☆＊＊・＊＊☆★★")
          (res ""))
      (cl-do ((i 0 (+ i 1))) ((not (< i n)))
        (let* ((current-idx (mod (+ i offset) (length stars)))
               (current-str (string (elt stars current-idx))))
          (setq res (concat res current-str))))
      res))

  ;; (highlight-regexp "★" 'all-the-icons-yellow)
  ;; (highlight-regexp "☆" 'all-the-icons-yellow)
  ;; (highlight-regexp "＊" 'all-the-icons-yellow)

  ;; カーソルの位置を (middle top bottom) と移す関数．
  ;; recenter-top-bottom を参考に作成した．
  (defvar my-cursor-positions '(middle top bottom))
  (defun my-recenter-cursor ()
    (interactive)
    (setq my-cursor-last-position
          (if (eq this-command last-command)
              (car (or (cdr (member my-cursor-last-position my-cursor-positions))
                       my-cursor-positions))
            (car my-cursor-positions)))
    (cond ((eq my-cursor-last-position 'middle) (evil-window-middle))
          ((eq my-cursor-last-position 'top) (evil-window-top))
          ((eq my-cursor-last-position 'bottom) (evil-window-bottom))
          (t (message "Unreachable"))))

  ;; (define-key evil-normal-state-map
  ;;   (kbd "SPC")
  ;;   (defhydra hydra-space (:color pink)
  ;;     ("j" (lambda () (interactive) (evil-next-line 5)))
  ;;     ("g" nil "leave")
  ;;     )
  ;;   )

;;   (defhydra hydra-space (evil-normal-state-map "SPC")
;;     "
;; %s(get-stars (- (/ (frame-total-cols) 2) 1) 0)
;; "
;;     ;; ("j" (lambda () (interactive) (evil-next-line 5)))
;;     ;; ("SPC" (lambda () (interactive) ()))
;;     ("j" (lambda () (interactive) (evil-next-line 5)))
;;     ;; ("j" (lambda () (interactive) (next-line 5)))
;;     ("k" (lambda () (interactive) (evil-previous-line 5)))
;;     ;; ("k" (lambda () (interactive) (previous-line 5)))
;;     ;; ("h" (lambda () (interactive) (evil-backward-char 5)))
;;     ;; ("l" (lambda () (interactive) (evil-forward-char 5)))
;;     ("l" (lambda () (interactive) (recenter-top-bottom)))
;;     ;; ("h" (lambda () (interactive) (my-recenter-cursor)))
;;     ;; ("o" (lambda () (interactive) (other-window 1) (evil-force-normal-state) ))
;;     ;; ("g" nil "leave")
;;     ;; ("g" (lambda () (interactive) (redraw-display)) :exit t)
;;     ("h" (lambda () (interactive) (redraw-frame)) :exit t)
;;     ;; ("SPC" nil "leave")
;;     )

  (defun hydra-space-j () (interactive) (evil-next-line 5))
  (defun hydra-space-k () (interactive) (evil-previous-line 5))
  (defun hydra-space-l () (interactive) (recenter-top-bottom))
  (defhydra hydra-space (:post (progn
                                 (redraw-frame)
                                 (message "Thank you, come again.")
                                 ))
    "
%s(format \"%s\" (propertize
                  (format \"%s\" (get-stars (- (/ (frame-total-cols) 2) 1) 0))
                  'face `(:foreground \"darkorange\")
                  ))
"
    ("j" hydra-space-j)
    ("k" hydra-space-k)
    ("l" hydra-space-l)
    ("g" nil "leave")
    )
  (define-key my-space-map (kbd "j") 'hydra-space/hydra-space-j)
  (define-key my-space-map (kbd "k") 'hydra-space/hydra-space-k)
  (define-key my-space-map (kbd "l") 'hydra-space/hydra-space-l)

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
  ;; :defer
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
  ;; (setq neo-window-width 20)
  ;; (neo-theme 'nerd2)
  ;; (bind-key "<left>" 'neotree-select-up-node neotree-mode-map)
  (define-key evil-normal-state-map (kbd "SPC n") 'neotree-toggle)
  (define-key neotree-mode-map (kbd "C-f") 'neotree-change-root)
  ;; (bind-key "<right>" 'neotree-change-root neotree-mode-map)
  (bind-key "C-f" 'neotree-change-root neotree-mode-map)
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

  ;; Redefine to deal with args-out-of-range error
  (defun google-translate-json-suggestion (json)
    "Retrieve from JSON (which returns by the
`google-translate-request' function) suggestion. This function
does matter when translating misspelled word. So instead of
translation it is possible to get suggestion."
    (let ((info (aref json 7)))
      (if (and info (> (length info) 0))
          (aref info 1)
        nil)))
  )

(use-package tramp
  :ensure t
  :config
  (message ":config tramp")
  )

;; (use-package awesome-tab
;;   :load-path "nora/awesome-tab"
;;   :config
;;   (message ":config awesome-tab")
;;   (awesome-tab-mode t)
;;   (setq awesome-tab-label-fixed-length 14)
;;   (setq awesome-tab-height 100)
;;   )

;; ;; tab-bar-mode
;; (if (fboundp 'tab-bar-mode)
;;     ;; Emacs 27.1 or more => OK
;;     (tab-bar-mode 1)
;;    )

;; (use-package centaur-tabs
;;   :ensure t
;;   :config
;;   (message ":config centaur-tabs")
;;   (setq centaur-tabs-set-icons t
;;         ;; centaur-tabs-set-bar 'left
;;         centaur-tabs-set-bar 'over
;;         centaur-tabs-gray-out-icons 'buffer
;;         ;; centaur-tabs-height 22
;;         centaur-tabs-height 26
;;         ;; centaur-tabs-height 32
;;         centaur-tabs-set-modified-marker t
;;         )
;;   (centaur-tabs-change-fonts "Migu 1M" 140)
;;   (centaur-tabs-headline-match)
;;   (centaur-tabs-mode t)
;;   )

(use-package popwin
  :ensure t
  :custom
  (popwin:popup-window-position 'bottom)
  :config
  (message ":config popwin")
  (popwin-mode 1)
  )

(use-package sr-speedbar
  :ensure t
  :config
  (message ":config sr-speedbar")
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

;; (use-package vterm
;;   :ensure t
;;   :config
;;   (message ":config vterm")
;;   )

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
         ("\\.hpp" . c++-mode)
         ("\\.h" . c++-mode)
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
  (add-hook
   'c-mode-hook
   (lambda ()
     (set (make-local-variable 'compile-command)
          (format "gcc -Wall -Wextra %s"
                  (file-name-nondirectory buffer-file-name)))))

  ;; Comment out
  (add-hook 'c-mode-hook
            (function (lambda ()
                        (setq comment-start "// ")
                        (setq comment-end ""))))

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

  (evil-define-key 'normal csv-mode-map (kbd "F")
    '(lambda (hard beg end)
       (interactive (cons current-prefix-arg
                          (if (use-region-p)
                              (list (region-beginning) (region-end))
                            (list (point-min) (point-max)))))
       (csv-align-fields hard beg end)
       ;; (csv-align-fields nil (window-start) (window-end)) ; Only for visible lines
       (save-buffer)
       (message "csv-align-fields")
       )
    )
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
  ;; (setq rust-format-on-save t)

  ;; Formatter
  (add-hook
   'rust-mode-hook
   (lambda ()
     (define-key evil-normal-state-map (kbd "F")
       (lambda ()
         (interactive)
         (rust-format-buffer)
         (save-buffer)
         (message "\"rustfmt\" and \"save-buffer\"")))))

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

  ;; Run command
  (defun my-go-run ()
    (interactive)
    (let ((cmd (concat "go run " (file-name-base) ".go")))
      (save-buffer)
      (async-shell-command cmd)))
  (evil-define-key 'normal go-mode-map (kbd "C-j") 'my-go-run)

  (defun my-go-async-shell-command
      (command &optional output-buffer error-buffer)
    (interactive
     (list (read-shell-command "Async shell command: "
                               (concat "go run " (file-name-base) ".go ")
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

  (evil-define-key 'normal go-mode-map (kbd "C-S-j")
    'my-go-async-shell-command)

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

  (define-key evil-normal-state-map (kbd "L") 'markdown-follow-link-at-point)

  (use-package markdown-toc
    :ensure t
    :config
    (message ":config markdown-toc")
    )

  (use-package markdownfmt
    ;; cf. https://github.com/nlamirault/emacs-markdownfmt
    :ensure t
    :config
    (message ":config markdownfmt")
    )

  ;; Formatter
  (add-hook
   'markdown-mode-hook
   (lambda ()
     (define-key evil-normal-state-map (kbd "F")
       '(lambda ()
          (interactive)
          (markdownfmt-format-buffer)
          (save-buffer)
          (message "\"markdownfmt-format-buffer\" and \"save-buffer\"")
          ))
     ))

  ;; ;; From doom-one
  ;; (set-face-foreground 'markdown-header-face "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-face-1 "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-face-2 "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-face-3 "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-face-4 "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-face-5 "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-face-6 "#ff6c6b")
  ;; (set-face-foreground 'markdown-header-delimiter-face "#ff6c6b")

  ;; ;; My custom
  ;; (set-face-foreground 'markdown-header-face "#ff6040")
  ;; (set-face-foreground 'markdown-header-face-1 "#ff6040")
  ;; (set-face-foreground 'markdown-header-face-2 "#ff6040")
  ;; (set-face-foreground 'markdown-header-face-3 "#ff6040")
  ;; (set-face-foreground 'markdown-header-face-4 "#ff6040")
  ;; (set-face-foreground 'markdown-header-face-5 "#ff6040")
  ;; (set-face-foreground 'markdown-header-face-6 "#ff6040")
  ;; (set-face-foreground 'markdown-header-delimiter-face "#ff6040")

  ;; From doom-theme
  ;; markdown-inline-code-face -> markdown-code-face, markdown-pre-face
  ;; markdown-code-face: Background: #2e3138
  ;; markdown-pre-face: Foreground: #98be65

  ;; From modus-themes
  ;; markdown-inline-code-face: Foreground: #fbd6f4, Background: #191a1b
  ;; markdown-code-face: Background: #100f10
  ;; markdown-pre-face: Foreground: #bfebe0

  ;; ;; My custom
  ;; (set-face-background 'markdown-code-face "#2e3138")
  ;; (set-face-background 'markdown-inline-code-face "#2e3138")
  ;; (set-face-foreground 'markdown-inline-code-face "#bfebe0")
  ;; (set-face-foreground 'markdown-pre-face "#bfebe0")
  )

;; (use-package markdown-mode
;;   :ensure t
;;   :mode (("\\.rst\\'" . rst-mode))
;;   :config
;;   (message ":config: rst-mode")
;;   )

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
      ;; (if (get-buffer "*Async Shell Command*")
      ;;     ;; (message "foo")
      ;;     ;; (delete-window "*Async Shell Command*")
      ;;   (message "bar")
      ;;   )
      (async-shell-command mycommand)
      ;; (delete-window)
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
  ;; :commands (realgud:pdb realgud:gdb)
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
;;   (python-mode . lsp)
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

(use-package dockerfile-mode
  :ensure t
  :mode (("Dockerfile" . dockerfile-mode))
  :config
  (message ":config dockerfile-mode")
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Edit

;; Windows IME (~26)
;; cf. https://github.com/mhatta/emacs-27-x86_64-win-ime
(if (<= emacs-major-version 26)
    (when (eq system-type 'windows-nt)
      (setq default-input-method "W32-IME")
      (setq-default w32-ime-mode-line-state-indicator "[--]")
      (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
      (w32-ime-initialize)
      )
  )

;; Windows IME (27~)
;; cf. https://github.com/trueroad/tr-emacs-ime-module
(if (and (>= emacs-major-version 27)
         (eq system-type 'windows-nt))
    (use-package tr-ime
      :ensure t
      :config
      (message ":config tr-ime")
      (tr-ime-standard-install)
      ;; IM のデフォルトを IME に設定
      (setq default-input-method "W32-IME")
      ;; IME のモードライン表示設定
      (setq-default w32-ime-mode-line-state-indicator "[--]")
      (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
      ;; IME 初期化
      (w32-ime-initialize)
      ;; ;; IME 制御（yes/no などの入力の時に IME を off にする）
      ;; (wrap-function-to-control-ime 'universal-argument t nil)
      ;; (wrap-function-to-control-ime 'read-string nil nil)
      ;; (wrap-function-to-control-ime 'read-char nil nil)
      ;; (wrap-function-to-control-ime 'read-from-minibuffer nil nil)
      ;; (wrap-function-to-control-ime 'y-or-n-p nil nil)
      ;; (wrap-function-to-control-ime 'yes-or-no-p nil nil)
      ;; (wrap-function-to-control-ime 'map-y-or-n-p nil nil)
      ;; (wrap-function-to-control-ime 'register-read-with-preview nil nil)
      )
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
  ((prog-mode yatex-mode markdown-mode) . yas-minor-mode)
  :config
  (message ":config yasnippet")
  (yas-reload-all)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
  )

(use-package git-gutter
  :ensure t
  :after ivy
  ;; :custom
  ;; (git-gutter:modified-sign "~")
  ;; (git-gutter:added-sign    "+")
  ;; (git-gutter:deleted-sign  "-")
  ;; :custom-face
  ;; (git-gutter:modified ((t (:background "#f1fa8c" :foreground "black"))))
  ;; (git-gutter:added    ((t (:background "#50fa7b" :foreground "black"))))
  ;; (git-gutter:deleted  ((t (:background "#ff79c6" :foreground "black"))))
  :custom
  (git-gutter:window-width 2)
  (git-gutter:modified-sign "☁")
  (git-gutter:added-sign "☀")
  (git-gutter:deleted-sign "☂")
  :custom-face
  (git-gutter:modified ((t (:foreground "gray" :background "#282a36"))))
  (git-gutter:added    ((t (:foreground "orange" :background "#282a36"))))
  (git-gutter:deleted  ((t (:foreground "cyan" :background "#282a36"))))
  ;; (git-gutter:modified ((t (:foreground "gray" :background "black"))))
  ;; (git-gutter:added    ((t (:foreground "orange" :background "black"))))
  ;; (git-gutter:deleted  ((t (:foreground "cyan" :background "black"))))
  ;; NOTE 2020-04-01: To get the theme color, try `describe-face RET default`
  :config
  (message ":config git-gutter")
  (global-git-gutter-mode +1)

  ;; Mercurial
  (custom-set-variables
   '(git-gutter:handled-backends '(git hg)))
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

;; (use-package highlight-symbol
;;   :ensure t
;;   :after ivy
;;   :hook
;;   (prog-mode . highlight-symbol-mode)
;;   :config
;;   (message ":config highlight-symbol")
;;   ;; Key binding
;;   ;; (define-key evil-normal-state-map (kbd "n") 'highlight-symbol-next)
;;   ;; (define-key evil-normal-state-map (kbd "p") 'highlight-symbol-prev)
;;   )

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

  ;; ;; Default?
  ;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#9a4040")
  ;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#ff5e5e")
  ;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#ffaa77")
  ;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#dddd77")
  ;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#80ee80")
  ;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#66bbff")
  ;; (set-face-foreground 'rainbow-delimiters-depth-7-face "#da6bda")
  ;; (set-face-foreground 'rainbow-delimiters-depth-8-face "#afafaf")
  ;; (set-face-foreground 'rainbow-delimiters-depth-9-face "#f0f0f0")

  ;; ;; From doom-dracula
  ;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#61bfff")
  ;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#ff79c6")
  ;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#50fa7b")
  ;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#ffb86c")
  ;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#bd93f9")
  ;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#f1fa8c")
  ;; (set-face-foreground 'rainbow-delimiters-depth-7-face "#0189cc")
  ;; (set-face-foreground 'rainbow-delimiters-depth-8-face "#a2b6da")
  ;; (set-face-foreground 'rainbow-delimiters-depth-9-face "#9cb6ad")

  ;; ;; From doom-one
  ;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#51afef")
  ;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#c678dd")
  ;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#98be65")
  ;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#da8548")
  ;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#a9a1e1")
  ;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#ECBE7B")
  ;; (set-face-foreground 'rainbow-delimiters-depth-7-face "#4db5bd")
  ;; (set-face-foreground 'rainbow-delimiters-depth-8-face "#a2b6da")
  ;; (set-face-foreground 'rainbow-delimiters-depth-9-face "#9cb6ad")

  ;; ;; From modus-themes
  ;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#ffffff")
  ;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#ff62d4")
  ;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#3fdfd0")
  ;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#fba849")
  ;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#9f80ff")
  ;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#4fe42f")
  ;; (set-face-foreground 'rainbow-delimiters-depth-7-face "#fe6060")
  ;; (set-face-foreground 'rainbow-delimiters-depth-8-face "#4fafff")
  ;; (set-face-foreground 'rainbow-delimiters-depth-9-face "#f0dd60")

  ;; My custom (based on modus-themes)
  (set-face-foreground 'rainbow-delimiters-depth-1-face "#4fafff")
  (set-face-foreground 'rainbow-delimiters-depth-2-face "#ff62d4")
  (set-face-foreground 'rainbow-delimiters-depth-3-face "#4fe42f")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "#fba849")
  (set-face-foreground 'rainbow-delimiters-depth-5-face "#9f80ff")
  (set-face-foreground 'rainbow-delimiters-depth-6-face "#f0dd60")
  (set-face-foreground 'rainbow-delimiters-depth-7-face "#fe6060")
  (set-face-foreground 'rainbow-delimiters-depth-8-face "#3fdfd0")
  (set-face-foreground 'rainbow-delimiters-depth-9-face "#ffffff")
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
  ;; (setq hl-todo-keyword-faces
  ;;       '(("★"   . "#FF0000")
  ;;         ("☆"  . "#FF0000")
  ;;         ("package" "#A020F0")
  ;;         ("＊"  . "#A020F0")))
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
           (cons ".*" (concat (file-name-directory user-init-file) "backup/backup"))
           backup-directory-alist))

    ;; 2. auto-save file: #aaa.txt#
    (setq backup-inhibited nil)
    (setq delete-auto-save-files nil)
    (setq auto-save-timeout 3)     ;; sec
    (setq auto-save-interval 100)  ;; keystroke
    (let ((autosave-dir (concat (file-name-directory user-init-file) "backup/autosave/")))
      (unless (file-exists-p autosave-dir)
        (make-directory autosave-dir :parents)
        ))
    (setq auto-save-file-name-transforms
          `((".*" ,(concat (file-name-directory user-init-file) "backup/autosave/") t)))

    ;; 3. lock file: .#aaa.txt
    (setq create-lockfiles nil)
    ))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; @ Other

(use-package restart-emacs
  :ensure t
  :commands restart-emacs
  :config
  (message ":config restart-emacs")
  ;; You cannot see this message forever!!
  )

;; (use-package golden-ratio
;;   :ensure t
;;   :diminish golden-ratio-mode
;;   :init (golden-ratio-mode 1)
;;   :config
;;   (message ":config golden-ratio")
;;   )

;; アイドル状態のときにガベージコレクトしてくれる
(use-package gcmh
  :ensure t
  :config
  (message ":config gcmh")
  (gcmh-mode 1)

  ;; GC 後に利用メモリサイズを出力する
  (defun grugrut/gc-debug-function (str)
    (let ((sum 0))
      (dolist (x str)
        (setq sum (+ sum (* (cl-second x) (cl-third x)))))
      (message "Used Memory: %d MB" (/ sum (* 1024 1024)))))
  (advice-add 'garbage-collect :filter-return #'grugrut/gc-debug-function)
  )

(add-hook
 'after-init-hook
 ;; 'emacs-startup-hook
 '(lambda ()
    (column-number-mode t) ; 列番号の表示
    (setq inhibit-startup-message t)
    ;; (setq frame-title-format
    ;;       '("emacs " emacs-version (buffer-file-name " - %f")))
    (setq frame-title-format '("emacs " emacs-version))
    ;; NOTE Doom modeline background color is `#373B47`. So if you want to set
    ;; up title bar like doom modeline, you should set by mannually outside
    ;; emacs.

    ;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    ;; (add-to-list 'default-frame-alist '(ns-appearance . red))

    (set-frame-parameter nil 'alpha 98)
    ;; (set-frame-parameter nil 'alpha 93)
    (electric-pair-mode 1)
    ;; (setq scroll-step 1)
    (save-place-mode 1)
    (setq scroll-conservatively 10000)
    (setq scroll-margin 1)
    (setq require-final-newline t)
    (setq scroll-preserve-screen-position t)
    (setq redisplay-dont-pause t)
    (fset 'yes-or-no-p 'y-or-n-p)

    ;; paren
    (show-paren-mode t)
    (setq show-paren-delay 0.1)

    ;; autorevert
    ;; Emacs 以外でファイルが書き変わったときに自動的に読み直すマイナーモード．
    (global-auto-revert-mode 1)
    (setq auto-revert-interval 2)

    ;; Hi-lock: (("★" (0 (quote all-the-icons-yellow) prepend)))
    ;; (global-hi-lock-mode 1)
    ;; (highlight-regexp "★" 'all-the-icons-yellow)
    ;; (highlight-regexp "★" 'all-the-icons-yellow)
    ;; (add-hook 'text-mode-hook
    ;;           '(lambda ()
    ;;              (hi-lock-set-pattern "★" 'all-the-icons-yellow)
    ;;              )
    ;;           )


    (when (eq system-type 'windows-nt)

      (use-package unicode-fonts
        :ensure t
        :config
        (message ":config unicode-fonts")
        (unicode-fonts-setup)
        )

      ;; デフォルトフォント
      ;; (set-frame-font "Migu 1M-12:antialias=standard")
      ;; (set-frame-font "Migu 1M-13:antialias=standard")
      (set-frame-font "Migu 1M-14:antialias=standard")

      ;; 日本語フォント：あいうえお ... 日本語
      (set-fontset-font
       'nil 'japanese-jisx0208 (font-spec :family "Migu 1M" :height 120))

      ;; TODO: ギリシャ文字を半角にしたい

      ;; ;; ギリシャ文字：αβγκλ ... ΛΩ
      ;; (set-fontset-font
      ;;  'nil '(#x0370 . #x03FF) (font-spec :family "Migu 1M" :height 100))

      ;; ;; キリル文字：Эта статья ... Русский
      ;; (set-fontset-font
      ;;  'nil '(#x0400 . #x04FF) (font-spec :family "MSP明朝" :height 100))

      ;; For surface
      (when (equal system-name "DESKTOP-U491J4T")
        (set-frame-font "Migu 1M-11:antialias=standard"))
      )

    (when (eq system-type 'gnu/linux)
      (set-fontset-font "fontset-default"
                        'japanese-jisx0208
                        '("Noto Sans CJK JP Medium" . "iso10646-1")) ; For WSL
      ;; (set-frame-font "Migu 1M-12:antialias=standard")
      ;; (set-frame-font "Migu 1M-13:antialias=standard")
      (set-frame-font "Migu 1M-13.5:antialias=standard")
      ;; (set-frame-font "Migu 1M-14:antialias=standard")
      )

    ;; Distinguish "C-i" and "TAB"
    (define-key input-decode-map "\C-i" [C-i])

    ;; Spell check
    (setq-default ispell-program-name "aspell")
    (with-eval-after-load "ispell"
      (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

    ;; Key binding
    (define-key global-map (kbd "C-h") (kbd "DEL"))
    (define-key global-map (kbd "<C-i>") 'dabbrev-expand)
    (global-set-key (kbd "C-8") 'start-kbd-macro)
    (global-set-key (kbd "C-9") 'end-kbd-macro)
    (global-set-key (kbd "C-0") 'call-last-kbd-macro)

    (global-set-key (kbd "C-+") 'text-scale-increase)
    (global-set-key (kbd "C-;") 'text-scale-increase)
    (global-set-key (kbd "C--") 'text-scale-decrease)

    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 4)

    ;; 「C-u C-SPC」「C-u C-SPC」「C-u C-SPC」...
    ;; => 「C-u C-SPC」「C-SPC」「C-SPC」...
    (setq set-mark-command-repeat-pop t)
    (setq mark-ring-max 64)             ; default: 16

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
 '(ansi-color-names-vector
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(avy-migemo-function-names
   '(swiper--add-overlays-migemo
     (swiper--re-builder :around swiper--re-builder-migemo-around)
     (ivy--regex :around ivy--regex-migemo-around)
     (ivy--regex-ignore-order :around ivy--regex-ignore-order-migemo-around)
     (ivy--regex-plus :around ivy--regex-plus-migemo-around)
     ivy--highlight-default-migemo ivy-occur-revert-buffer-migemo ivy-occur-press-migemo avy-migemo-goto-char avy-migemo-goto-char-2 avy-migemo-goto-char-in-line avy-migemo-goto-char-timer avy-migemo-goto-subword-1 avy-migemo-goto-word-1 avy-migemo-isearch avy-migemo-org-goto-heading-timer avy-migemo--overlay-at avy-migemo--overlay-at-full))
 '(custom-safe-themes
   '("f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" default))
 '(fci-rule-color "#6272a4")
 '(git-gutter:handled-backends '(git hg))
 '(helm-minibuffer-history-key "M-p")
 '(jdee-db-active-breakpoint-face-colors (cons "#1E2029" "#bd93f9"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1E2029" "#50fa7b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1E2029" "#565761"))
 '(package-selected-packages
   '(centaur-tabs all-the-icons-ivy-rich marginalia ivy-posframe gcmh minions moody modus-themes sr-speedbar tr-ime vterm markdownfmt ivy-prescient prescient unicode-fonts markdown-toc hydra-posframe highlight-symbol clang-format+ monky yasnippet which-key volatile-highlights use-package swiper-helm smooth-scroll realgud rainbow-mode rainbow-delimiters pt powerline origami nyan-mode neotree modalka minimap lsp-ui ivy-rich imenu-list hydra hl-todo highlight-indent-guides hide-mode-line hemisu-theme helm-make gruvbox-theme graphviz-dot-mode git-gutter ghub+ flymd flymake-diagnostic-at-point flycheck-posframe fill-column-indicator evil-magit evil-collection elisp-format doom-themes doom-modeline dashboard counsel company-box cmake-mode clang-format blacken beacon atom-dark-theme anzu amx all-the-icons-ivy ag))
 '(vc-annotate-background "#282a36")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50fa7b")
    (cons 40 "#85fa80")
    (cons 60 "#bbf986")
    (cons 80 "#f1fa8c")
    (cons 100 "#f5e381")
    (cons 120 "#face76")
    (cons 140 "#ffb86c")
    (cons 160 "#ffa38a")
    (cons 180 "#ff8ea8")
    (cons 200 "#ff79c6")
    (cons 220 "#ff6da0")
    (cons 240 "#ff617a")
    (cons 260 "#ff5555")
    (cons 280 "#d45558")
    (cons 300 "#aa565a")
    (cons 320 "#80565d")
    (cons 340 "#6272a4")
    (cons 360 "#6272a4")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added ((t (:foreground "orange" :background "#282a36"))))
 '(git-gutter:deleted ((t (:foreground "cyan" :background "#282a36"))))
 '(git-gutter:modified ((t (:foreground "gray" :background "#282a36"))))
 '(hl-todo ((t (:inherit nil :foreground "#ff6c6b" :weight bold))))
 '(realgud-bp-line-enabled-face ((t (:underline "red")))))
(put 'upcase-region 'disabled nil)
