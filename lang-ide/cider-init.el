(use-package aggressive-indent
  :ensure t)

(use-package clojure-mode
  :ensure t)

(use-package flycheck-clojure
  :defer t
  :commands (flycheck-clojure-setup)               ;; autoload
  :config
  (eval-after-load 'flycheck
    '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-pos-tip :ensure t
  :after flycheck)

(use-package cider
  :ensure t
  :hook
  (clojure-mode . (lambda()
                    (yas-reload-all)
                    (yas-minor-mode)
                    ;; (aggressive-indent-mode)
                    (eldoc-mode)
                    (aggressive-indent-mode)))
  (before-save . cider-format-buffer)
  :config
  (setq clojure-indent-style 'align-arguments)
  (setq clojure-align-forms-automatically t)
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (setq
   cider-repl-history-file ".cider-repl-history"  ;; not squiggly-related, but I like it
   nrepl-log-messages t)                          ;; not necessary, but useful for trouble-shooting
  (flycheck-clojure-setup))

(use-package clj-refactor
  :ensure t
  :diminish clj-refactor-mode
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package kibit-helper
  :ensure t
  :bind (("C-x C-`" . kibit-accept-proposed-change)))
