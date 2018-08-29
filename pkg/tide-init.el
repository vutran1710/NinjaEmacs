(use-package tide
  :ensure t
  :init (use-package web-mode :ensure t)
  :config
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))

  (defun company-tide-mode-hook ()
    (set (make-local-variable 'company-backends)
         '(company-dabbrev company-tern company-css company-web company-files company-keywords)))

  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (company-tide-mode-hook)
  (tide-hl-identifier-mode +1)
  (setq typescript-indent-level '2)
  (my/use-tslint-from-node-modules))

(defun my/use-tslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (tslint (and root
                      (expand-file-name "node_modules/tslint/bin/tslint.js"
                                        root))))
    (when (and tslint (file-executable-p tslint))
      (setq-local flycheck-javascript-tslint-executable tslint))))
