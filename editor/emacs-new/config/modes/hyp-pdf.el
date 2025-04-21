;; Configurations for all thing PDF and it's related modes

(add-to-list 'hyp/emacs-dep '("imagemagick"))

;; Homepage: https://github.com/politza/tablist
(use-package tablist
  :straight (tablist :type git :host github :repo politza/tablist))

;; TODO: If this fails to work, may have to install epdfinfo, I thought it would be installed with
;; the make command
;; Homepage: https://github.com/vedang/pdf-tools
(use-package pdf-tools
  :straight (pdf-tools :type git :host github :repo vedang/pdf-tools
		       :pre-build ("make" "-s"))
  :requires (tablist) ;; pdf-tools depends on tablist (not sure if it's a hard dependency)
  :magic ("%PDF" . pdf-view-mode) ;; runs the command pdf-view-mode when Buffer meets the regex %PDF
  :hook ((pdf-view-mode-hook . (lambda () (interactive) (display-line-numbers-mode -1)))
	 (pdf-view-mode-hook . (turn-off-evil-mode)))
  :general-config (pdf-view-mode-map
	      "j" 'pdf-view-next-line-or-next-page
	      "k" 'pdf-view-previous-line-or-previous-page)
  :config
  (pdf-tools-install :no-query))
  
