
(add-to-list 'load-path "~/.config/emacs/config/packages")
(add-to-list 'load-path "~/.config/emacs/config/modes")
(add-to-list 'load-path "~/.config/emacs/config/themes")
(add-to-list 'load-path "~/.config/emacs/config/keys")


(straight-use-package 'use-package)

(require 'hyp-globals)
(require 'hyp-evil)
(require 'hyp-interface)

