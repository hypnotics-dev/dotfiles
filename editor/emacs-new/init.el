
(add-to-list 'load-path "~/.config/emacs/config/packages")
(add-to-list 'load-path "~/.config/emacs/config/modes")
(add-to-list 'load-path "~/.config/emacs/config/themes")
(add-to-list 'load-path "~/.config/emacs/config/org")


;; Homepage: https://github.com/jwiegley/use-package
(straight-use-package
 '(use-package :type git :host github :repo "jwiegley/use-package"))

(require 'hyp-globals)
(require 'hyp-evil)
(require 'hyp-interface)

