;; Configuration relating to fonts

;; Homepage: https://github.com/domtronn/all-the-icons.el
(use-package all-the-icons
  :straight (:type git :host github :repo domtronn/all-the-icons.el)
  :if (display-graphic-p))

;; Homepage: https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiter
  :straight (:type git :host github :repo Fanael/rainbow-delimiters)
  :hook (prog-mode-hook . raibow-delimiters-mode))
