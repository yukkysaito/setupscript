;; ------------------------------------------------------------------------
;; scratchの初期メッセージ消去
(setq initial-scratch-message "")
;; ------------------------------------------------------------------------
;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
;; ------------------------------------------------------------------------
;;ediff
;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)
;; ------------------------------------------------------------------------
;; @ anything.el
;; http://d.hatena.ne.jp/rubikitch/20100718/anything
(require 'anything-startup nil t)
(global-set-key (kbd "C-x b") 'anything)
;;--------------------------
;; モードラインに行番号表示
(line-number-mode t)
;; モードラインに列番号表示
(column-number-mode t)
;;--------------------------
;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)
;;--------------------------
;; バックアップを残さない
(setq make-backup-files nil)
;;; バックアップファイルを作らない
(setq backup-inhibited t)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;;--------------------------
;;;起動時に最大化
(set-frame-parameter nil 'fullscreen 'maximized)
;;--------------------------
;; redoできるようにする
;; http://www.emacswiki.org/emacs/redo+.el
(when (require 'redo+ nil t)
  (define-key global-map (kbd "C-_") 'redo))
;;--------------------------
;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode
;;--------------------------
;; 行間
(setq-default line-spacing 0)
;;--------------------------
;;;画面分割
(add-hook 'after-init-hook (lambda()
   (setq w (selected-window))
;;   (setq w2 (split-window w nil t))
;;    (setq w3 (split-window w2 (- (window-height w) 16)))
;;    (select-window w3)
;;    (eshell)
;;    (select-window w2)
;;    (recentf-open-files)
;;    (select-window w)
    (recentf-open-files)))
;;--------------------------
;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#0FF"
                    :height 1.0)

;; 行番号フォーマット
(setq linum-format "%4d")
;;--------------------------
;; ツールバー非表示
(tool-bar-mode -1)
;;--------------------------
;; メニューバーを非表示
;;(menu-bar-mode -1)
;;--------------------------
;; スクロールバー非表示
(set-scroll-bar-mode nil)
;;--------------------------
;; 起動時の画面はいらない
(setq inhibit-startup-message t)
;;--------------------------
;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")
;;--------------------------
;; 行末の空白を保存時に削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;--------------------------
;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)
;; tab 幅を 4 に設定
(setq-default tab-width 4 indent-tabs-mode nil)
;;--------------------------
;;リング音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;;--------------------------
;; 透明度設定
(if window-system (progn
                    (set-background-color "Black")
                    (set-foreground-color "White")
                    (set-cursor-color "Gray")
                    (set-frame-parameter nil 'alpha 93)
                    ))
;;--------------------------
;;
(define-key global-map (kbd "C-c r") 'recentf-open-files)

;;--------------------------
;; ファイルの現在位置
(ffap-bindings)
;;--------------------------
;; 全角、タブを色付け
(defface my-face-tab         '((t (:background "Yellow"))) nil :group 'my-faces)
(defface my-face-zenkaku-spc '((t (:background "LightBlue"))) nil :group 'my-faces)
;;(defface my-face-spc-at-eol  '((t (:foreground "Red" :underline t))) nil :group 'my-faces)
(defvar my-face-tab         'my-face-tab)
(defvar my-face-zenkaku-spc 'my-face-zenkaku-spc)
;;(defvar my-face-spc-at-eol  'my-face-spc-at-eol)Book Air(Late2010) 11inch display
         (set-frame-position (selected-frame) 0 0)
         (set-frame-size (selected-frame) 95 47)
;;--------------------------
;; インデント等の設定
(defun set-c-mode-common-conf ()
  ;; (electric-mode + 自動インデント + 欲張り削除) ";"を押すと現在の行を
  ;; 再インデントして自動的に改行をするモードのなる設定。これは強力すぎて扱いづらい。
;;  (c-toggle-auto-hungry-state 1)

  ;; (electric-mode) ";"や"{"などをを入力した場合現在の行を自動インデントを有功にする
  (c-toggle-electric-state 1)

  ;; (欲張り削除 + electric-mode)バックスペースなどの削除するキーを押すと
  ;; スペースを一気に消す欲張り削除機能とelecetic-modeをを有功にする
  (c-toggle-hungry-state 1)

  ;; この関数は廃れた機能 (obsoleteされた)ものなので、emacsのバージョンが22.1以上なら使わないこと
  ;; (c-toggle-auto-state 1) obsoleted

  ;; (自動インデント) 改行をしたら次の行を自動でインデントしてくれる
  (c-toggle-auto-newline 1)

  ;; C-m を newline-and-indentに設定する
  ;; しかしこれをするとEnterのキーマップまで影響するので
  ;; 大人しくC-jを使ったnewline-and-indentを使うほうが
  ;; (define-key c-mode-base-map ""¥C-m" 'newline-and-indent)

  (c-set-style "stroustrup")                  ;; スタイルはストラウストラップ
;;  (flyspell-prog-mode)                        ;; flyspell-prog-mode(自動ispell機能)

  ;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
  ;; auto-revert-modeを有効にする
  (auto-revert-mode)
  )

;; C言語系のモード全てに適用されるフック
;; c-mode-common-hookにフックを設定する
(add-hook 'c-mode-common-hook 'set-c-mode-common-conf)
;;-------------------------
;; 括弧の範囲内を強調表示
(show-paren-mode t)(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; 括弧の範囲色
(set-face-background 'show-paren-match-face "#208")
;;-------------------------
;; オートコンプリート機能
(add-to-list 'load-path "~/.emacs.d/elisp/")
(require 'auto-complete-config)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)
;;--------------------------
;;;auto install機能
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;;--------------------------
;; 最近使ったファイルをメニューに表示
;; (recentf-mode t)
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 100)      ;; recentf に保存するファイルの数
(require 'recentf-ext)
;;--------------------------
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;;--------------------------
(require 'col-highlight)
;;常にハイライト
;;(column-highlight-mode 1)
;;一定時間後にハイライト
(toggle-highlight-column-when-idle 1)
(col-highlight-set-interval 6)
;;--------------------------
(set-face-attribute 'default nil
:height 130) ;; font size
;;--------------------------
(require 'anything-startup)
;;--------------------------
;; flymakeパッケージを読み込み
 (require 'flymake)
;; 全てのファイルでflymakeを有効化
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; miniBufferにエラーを出力
(defun flymake-show-and-sit ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (progn
    (let* ((line-no (flymake-current-line-no) )
           (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (count (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (full-file
                  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))
  (sit-for 60.0))
(global-set-key "\C-cd" 'flymake-show-and-sit)

;; flymakeの色を変更
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

;; Makefile が無くてもC/C++のチェック
(defun flymake-simple-generic-init (cmd &optional opts)
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list cmd (append opts (list local-file)))))

(defun flymake-simple-make-or-generic-init (cmd &optional opts)
  (if (file-exists-p "Makefile")
      (flymake-simple-make-init)
    (flymake-simple-generic-init cmd opts)))

(defun flymake-c-init ()
  (flymake-simple-make-or-generic-init
   "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(defun flymake-cc-init ()
  (flymake-simple-make-or-generic-init
   "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(push '("\\.c\\'" flymake-c-init) flymake-allowed-file-name-masks)
(push '("\\.\\(cc\\|cpp\\|C\\|CPP\\|hpp\\)\\'" flymake-cc-init)
      flymake-allowed-file-name-masks)
;;--------------------------
;;
;; tabber-mode
;;
(require 'tabbar)
(tabbar-mode 1)
;;
;; ref: http://d.hatena.ne.jp/plasticster/20110825/1314271209
;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; タブに表示させるバッファの設定
(defvar my-tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; appearances
(setq tabbar-separator '(1.0)) ;; タブセパレータの長さ
(set-face-attribute 'tabbar-default nil
                    :family "Ricty"
                    :foreground "#c4c1b0"
                    :background "#002c37"
                    :height 1.0)
(set-face-attribute 'tabbar-unselected nil
                    :foreground "#ffffff"
                    :background "#5533aa"
                    :box nil)
(set-face-attribute 'tabbar-selected nil
                    :foreground "#ffffff"
                    :background "#008800"
                    :box nil)
(set-face-attribute 'tabbar-button nil
                    :box nil)
(set-face-attribute 'tabbar-separator nil
                    :foreground "#002c37"
                    :background "#002c37"
                    :height 1.0)
;; key bindings
(global-set-key [(C-tab)]   'tabbar-forward-tab)
(global-set-key [(C-S-tab)] 'tabbar-backward-tab)
(global-set-key "\M-}"      'tabbar-forward-tab)
(global-set-key "\M-{"      'tabbar-backward-tab)
;; ------------------------------------------------------------------------
;; @ c-eldoc.el
;;カーソル付近にあるC言語の関数や変数のヘルプをエコーエリアに表示
(when (require 'c-eldoc nil t)
  (add-hook 'c-mode-hook
            (lambda ()
              (set (make-local-variable 'eldoc-idle-delay) 0.2)
              (set (make-local-variable 'eldoc-minor-mode-string) "")
              (c-turn-on-eldoc-mode))))
;; ------------------------------------------------------------------------
;; @ hideshow/fold-dwim.el
;; ブロックの折畳みと展開
;; http://www.dur.ac.uk/p.j.heslin/Software/Emacs/Download/fold-dwim.el
(when (require 'fold-dwim nil t)
  (require 'hideshow nil t)
  ;; 機能を利用するメジャーモード一覧
  (let ((hook))
    (dolist (hook
             '(emacs-lisp-mode-hook
               c-mode-common-hook
               python-mode-hook
               php-mode-hook
               ruby-mode-hook
               js2-mode-hook
               css-mode-hook
               apples-mode-hook))
      (add-hook hook 'hs-minor-mode))))
;;-----------------------------------------
;;ウィンドウの上部に現在の関数名を表示
;; 2011-03-15
(which-function-mode 1)
;;------------------------------
(define-key global-map (kbd "M-C-g") 'grep)               ; grep
;; 再帰的にgrep
;; 2011-02-18
(require 'grep)
(setq grep-command-before-query "grep -nH -r -e ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")
                         (+ (length grep-command-before-query) 1)))
;;------------------------------
(define-key global-map (kbd "C-[ M-C-g") 'goto-line)      ; 指定行へ移動
;;------------------------------
;; @ wgrep.el
;;grepから検索結果を直接編集
;; https://raw.github.com/mhayashi1120/Emacs-wgrep/master/wgrep.el
(require 'wgrep nil t)
;;------------------------------
;;
;; emacs-nav
;;
(require 'nav)
(global-set-key (kbd "<f8>") 'nav-toggle)
(global-set-key [(C x) (C j)] 'nav-toggle)  ; override of 'dired-jump
(custom-set-variables
 '(nav-width 20))

(defun nav-mode-hl-hook ()
  (local-set-key (kbd "<right>") 'nav-open-file-under-cursor)
  (local-set-key (kbd "<left>")  'nav-go-up-one-dir)
  )

(add-hook 'nav-mode-hook 'nav-mode-hl-hook)
;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (nav-toggle-hidden-files)
;;             ))
