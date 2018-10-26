
;; package管理
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(add-to-list 'load-path "/usr/local/share/gtags")
(package-initialize)
;;(set-face-background 'default "gray20")
;;(add-to-list 'default-frame-alist '(foreground-color . "white")
;;			'(cursor-type      . "bar") )

;;共通設定
;; line numberの表示
(require 'linum)
(global-linum-mode 1)

;; tabサイズ
(setq default-tab-width 4)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)


;; カーソル行をハイライトする
;;(global-hl-line-mode t)

;;選択行をハイライト
(transient-mark-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)
(setq show-paren-style 'expression)

;;; 起動時の画面はいらない
(setq inhibit-startup-message t)

;; 選択範囲に色をつける
(transient-mark-mode t)
(set-face-background 'region "#ff0048") ;選択範囲の色

;;treeを表示
(require 'neotree)
(global-set-key "\C-a" 'neotree-toggle)

;; 現在ポイントがある関数名をモードラインに表示
(which-function-mode 1)

;; スクロールは1行ごとに
(setq mouse-wheel-scroll-amount '(3 ((shift) . 5)))

;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;;行番号表示
;;(global-linum-mode t)


;;定義ジャンプのショートカットキー
(define-key global-map "\C-f" 'grep-find)
;(define-key global-map "\C-d" 'xref-find-definitions)
(define-key global-map "\C-e" 'pop-tag-mark)
(define-key global-map "\C-s" 'save-buffer)
(define-key global-map "\C-w" 'write-file)
(define-key global-map "\C-z" 'advertised-undo)
(define-key global-map "\C-cc" 'copy-region-as-kill)
(define-key global-map "\C-v" 'yank)
(define-key global-map "\C-q" 'save-buffers-kill-emacs)
(define-key global-map "\C-t" 'compile)
(define-key global-map "\C-n" 'next-error)
(define-key global-map "\C-r" 'query-replace)

(load-theme 'atom-one-dark t)


(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))


;; 自動エラーチェック
(require 'flymake)
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s" "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))
(global-set-key "\C-d" 'flymake)

;;自動エラーチェック
(require 'flycheck)
(global-flycheck-mode)
(global-set-key "\C-cn" 'flycheck-next-error)
(global-set-key "\C-cp" 'flycheck-previous-error)
;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; 行末の空白を強調表示
;;(setq-default show-trailing-whitespace t)
;;(set-face-background 'trailing-whitespace "#b14770")




;;c言語
;;補完


(require 'company)
(add-hook 'c-mode-common-hook 'company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)

(require 'irony)
(add-hook 'c-mode-common-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ; backend追加
;(add-hook 'c-mode-hook 'yas-global-mode)




;;括弧2個
(add-hook 'c-mode-common-hook
          (lambda ()
         ;;(define-key c-mode-base-map "\"" 'electric-pair)
         ;;(define-key c-mode-base-map "\'" 'electric-pair)
         (define-key c-mode-base-map "(" 'electric-pair)
         (define-key c-mode-base-map "[" 'electric-pair)
		 (define-key c-mode-base-map "\'" 'electric-pair)
         (define-key c-mode-base-map "\"" 'electric-pair)
		 (define-key c-mode-base-map "{" 'electric-pair)))








;;c++
(add-hook 'c++-mode-hook
		  (lambda ()
			(require 'auto-complete)))



;;java8
(use-package ensime
  :ensure t
  :pin melpa)





;;Python
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
			(define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)))

(require 'epc)
(require 'auto-complete-config)
(require 'python)
(setenv "PYTHONPATH" "/usr/local/lib/python2.7/dist-packages/")
(setenv "PYTHONPATH" "/usr/lib/python2.7/dist-packages/")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)





;;Latex
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-prefix "\C-t")
(setq tex-command "platex")
(setq bibtex-command "pbibtex")
(setq dviprint-command-format "dvipdfmx %s")
;; use utf-8 on yatex mode
(setq YaTeX-kanji-code 4)

(add-hook 'yatex-mode-hook
         '(lambda ()
         (YaTeX-define-key "p" 'latex-math-preview-expression)
         (YaTeX-define-key "\C-p" 'latex-math-preview-save-image-file)
         (YaTeX-define-key "j" 'latex-math-preview-insert-symbol)
         (YaTeX-define-key "\C-j" 'latex-math-preview-last-symbol-again)
         (YaTeX-define-key "\C-b" 'latex-math-preview-beamer-frame)))
(setq latex-math-preview-in-math-mode-p-func 'YaTeX-in-math-mode-p)

(add-hook 'yatex-mode-hook 'turn-on-reftex) ;;C-c [







;;web開発(html, js, css)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(clang-format yatex jedi-direx ensime use-package company-jedi rainbow-mode company-tern web-mode js2-mode js-auto-format-mode irony python-mode neotree jedi flycheck company auto-highlight-symbol atom-one-dark-theme atom-dark-theme))))

(add-hook 'js-mode-hook #'js-auto-format-mode)
;;(add-hook 'js-mode-hook #'add-node-modules-path)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(require 'web-mode)
(defun web-mode-hook ()
  "Hooks for Web mode."

  ;; indent
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)

  (local-set-key (kbd "C-m") 'newline-and-indent)

  ;; auto tag closing
  ;0=no auto-closing
  ;1=auto-close with </
  ;2=auto-close with > and </
  (setq web-mode-tag-auto-close-style 2)
  )
(add-hook 'web-mode-hook 'web-mode-hook)

;;web-modeでの配色
(add-hook 'web-mode-hook 'web-mode-hook
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;;  Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "MediumBlue"))))
 '(transient ((t (:background "red"))))
 '(web-mode-comment-face ((t (:foreground "#587F35"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-css-pseudo-class ((t (:foreground "#DFCF44"))))
 '(web-mode-css-selector-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-string-face ((t (:foreground "#D78181"))))
 '(web-mode-doctype-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-equal-face ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#D78181"))))
 '(web-mode-html-tag-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-server-comment-face ((t (:foreground "#587F35"))))))

(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'php-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "MediumBlue"))))
 '(transient ((t (:background "red"))))
 '(web-mode-comment-face ((t (:foreground "#587F35"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-css-pseudo-class ((t (:foreground "#DFCF44"))))
 '(web-mode-css-selector-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-string-face ((t (:foreground "#D78181"))))
 '(web-mode-doctype-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-equal-face ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#D78181"))))
 '(web-mode-html-tag-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-server-comment-face ((t (:foreground "#587F35")))))
