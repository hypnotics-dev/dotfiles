;; Configuration for delimiters

;; Homepage: https://github.com/tslilc/siege-mode
;; I think this creates some auto keys, we should unbind them
(use-package siege-mode
  :straight (:type git :host github :repo tslilc/siege-mode)
  :general-config
  (:states 'visual
	   "M-<SPC>s" 'siege-explicit-call)
  :custom
  (siege-mode))


