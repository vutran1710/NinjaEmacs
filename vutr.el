;;; package -- Summary
;;; Commentary:
;;; Emacs config entry-point
;;; Code:

;; Add paths
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/extras")

;; setup: pre
(require 'base-settings)
(require 'global-packages-setup)
(require 'zop-to-char)

;; programming load
(require 'vutr-python)
(require 'vutr-tide)
(require 'vutr-clojure)
(require 'vutr-julia)

;; setup: post
(require 'user-defined)
(require 'keybindings)
;;; vutr ends here
