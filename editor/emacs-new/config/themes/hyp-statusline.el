;; Configuration for the status line

;; Homepage: https://github.com/dbordak/telephone-line
;; TODO: Config the status line
(use-package telephone-line
  :straight (:type git :host github :repo telephone-line)
  :config
  (telephone-line-mode 1))
