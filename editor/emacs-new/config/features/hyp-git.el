;; Configurations for git related stuff
;; Packages to investigate:
;; https://github.com/magit/magit-imerge
;; 

;; Homepage: https://github.com/magit/transient
(use-package transient
  :straight (:type git :host github :repo magit/transient))

;; Homepage: https://github.com/magit/magit
;; DOCS: https://magit.vc/manual/magit.html
;; TODO: Create  vim like keybinds for magit
(use-package magit
  :straight (:source melpa)
  :hook (git-commit-mode-hook . flyspell-mode)
  :general-config
  ("C-x g" 'magit-status)
  (:state 'normal
	  :prefix "<SPC>g"
	  "d" 'magit-dispatch
	  "f" 'magit-file-dispatch)
  :custom
  (magit-define-global-key-bindings nil)
  (magit-repository-directories
   '(("~/dev/proj/" . 2)
     ("~/dev/dotfiles/" . 1)
     ("~/uni/CS/3/Professional_Practice-3997/" . 2)
     ("~/uni/CS/2/Formal_Languages-2333/" . 2)
     ("~/stuff/org/" . 1))))

;; Homepage: https://github.com/magit/forge
;; TODO: Figure out keybinds
(use-package forge
  :straight (:source melpa)
  :after magit)

;; Homepage: https://github.com/magit/git-modes
(use-package git-modes
  :straight (:source melpa))

;; Homepage https://github.com/tarsius/hl-todo
(use-package hl-todo
  :straight (:source melpa))

;; Homepage: https://github.com/alphapapa/magit-todos
;; TODO: Fix the keymap, defaults don't work well with evil
;; (use-package magit-todos
;;   :straight (magit-todos :source melpa)
;;   :after (magit async dash f hl-todo pcre2el s)
;;   :hook (magit-mode-hook . (lambda () (interactive) (magit-todos-mode 1))))
  
  
  

	      
