;; Configuration for package that are emacs front-ends for some cli

(add-to-list 'hyp/emacs-dep '("ripgrep"))

;; Homepage: https://github.com/mhayashi1120/Emacs-wgrep
;; TODO: Configure?
(use-package wgrep
  :straight (wgrep :type git :host github :repo mhayashi1120/Emacs-wgrep))

;; Homepage: https://github.com/dajva/rg.el
(use-package rg
  :straight (rg :type git :host github :repo dajva/rg.el)
  :after (transient wgrep)
  :custom
  (rg-keymap-prefix nil)
  :config
  (rg-enable-default-bindings nil)
  :general-config
  (rg-mode-map
   "j" 'compilation-next-error
   "k" 'compilation-previous-error
   "n" 'next-error-no-select
   "p" 'previous-error-no-select
   "u" 'rg-prev-file
   "d" 'rg-next-file
   "}" 'compilation-next-file
   "{" 'compilation-previous-file
   "RET" 'compile-goto-error
   "d" 'rg-rerun-change-dir
   "f" 'rg-rerun-change-files
   "l" 'rg-rerun-change-literal
   "r" 'rg-rerun-change-regexp
   "~" 'rg-rerun-toggle-case
   "h" 'rg-menu)
  (rg-mode-map
   :prefix "C-c"
   "p" 'rg-back-history
   "n" 'rg-forward-history
   "s" 'rg-save-search
   "C-s" 'rg-save-search-as-name
   "l" 'rg-list-searches
   "e" 'wgrep-change-to-wgrep-mode)
  (:states '(normal visual)
	   :prefix "<SPC>s"
	   "/" 'rg-isearch-menu ;; Run ripgrep using the regex from isearch on f d or p
	   "C-g" 'rg-menu ;; Use to craft more complex search
	   "M-g" 'rg-dwim ;; TODO Not sure how this works, find out
	   "g" 'rg)) ;; Use for basic regex search

;; Homepage: https://github.com/bling/fzf.el
(use-package fzf
  :straight (fzf :type git :host github :repo bling/fzf.el)
  :general-config
  (:states 'normal
	   :prefix "<SPC>s"
	   "f" 'fzf-find-file
	   "M-d" 'fzf-directory
	   "r" 'fzf-recentf
	   "S" 'fzf-grep-in-dir
	   "b" 'fzf-switch-buffer
	   "p" 'fzf-projectile)
  (:states 'normal
	   :prefix "<SPC>g"
	   "s" 'fzf-git-files
	   "g" 'fzf-git-grep)
  :config
  (setq
   fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
   fzf/executable "fzf"
   fzf/git-grep-args "-i --line-number %s"
   fzf/grep-command "rg --no-heading -nH"
   fzf/position-bottom t
   fzf/window-height 15))
  
  
