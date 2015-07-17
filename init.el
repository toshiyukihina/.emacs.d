(require'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; alpha setting
(add-to-list 'default-frame-alist '(alpha . 90))

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(tool-bar-mode 0)

(define-key global-map [?¥] [?\\])

;; Font setting
(set-face-attribute 'default nil :family "Menlo" :height 140)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16))

;; linum mode
(require 'linum)
(global-linum-mode)
(setq linum-format "%4d ")

;; Language and Coding System
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(setq-default tab-width 2)
(setq default-tab-width 2)
(setq-default indent-tabs-mode nil)

(transient-mark-mode 1)

(global-set-key "\C-h" 'delete-backward-char)

;; Javascript Mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq js-indent-level 2)
             (setq js-expr-indent-offset 2)
             (setq js2-basic-offset 2)
             (setq js2-enter-indents-newline t)
             ))

(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))

;; JSON Mode
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.gyp\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.gypi\\'" . json-mode))
(add-hook 'json-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq js-indent-level 2)
             ))

(require 'flymake-json)
(add-hook 'json-mode-hook 'flymake-json-load)

;; Markdown Mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;jsx
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-jsx-offset    2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)

;; sass-mode
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(defun sass-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'sass-mode-hook
          '(lambda() (sass-custom)))

;; ruby-mode
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(setq ruby-insert-encoding-magic-comment nil)

;; anything
(require 'anything)
(define-key global-map (kbd "C-;") 'anything)

;; docker
(add-to-list 'load-path "/your/path/to/dockerfile-mode/")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; git-gutter
(global-git-gutter-mode +1)
(custom-set-variables
 '(git-gutter:modified-sign "  ") ;; two space
 '(git-gutter:added-sign "++")    ;; multiple character is OK
 '(git-gutter:deleted-sign "--"))

(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(custom-set-variables
 '(git-gutter:handled-backends '(git hg)))

;; shell
(defun gker-setup-sh-mode ()
  (interactive)
  (setq sh-basic-offset 2
        sh-indentation 2))
(add-hook 'sh-mode-hook 'gker-setup-sh-mode)

;; Color theme
(require 'color-theme)
(load-theme 'wombat t)