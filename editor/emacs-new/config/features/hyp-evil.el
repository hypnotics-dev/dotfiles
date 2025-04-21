;; Configurations for the global Evil mode and related packages

;; Homepage: https://github.com/emacs-evil/goto-chg
(use-package goto-chg
  :straight (goto-chg :type git :host github :repo emacs-evil/goto-chg))

;; Homepage: https://codeberg.org/ideasman42/emacs-undo-fu
(use-package evil-undo-fu
  :straight (evil-undo-fu :type git :host codeberg :repo ideasman42/emacs-undo-fu)
  :custom
  (undo-limit 67108864 "Soft limit of 64MB")
  (undo-strong-limit 100663296 "Limit of 96MB")
  (undo-outer-limit 1006632960 "Hard limit of 960MB"))

;; Homepage: https://github.com/noctuid/general.el
;; TODO read up on general and create some notes somewhere.
;; Important Links:
;; https://github.com/noctuid/general.el?tab=readme-ov-file#best-practices
;; https://github.com/noctuid/general.el?tab=readme-ov-file#use-package-keywords
(use-package general
  :straight (:type git :host github :repo noctuid/general.el)
  :config
  (general-evil-setup t))

;; Homepage: https://github.com/emacs-evil/evil
(use-package evil
  :straight (:type git :host github :repo emacs-evil/evil)
  :after (goto-chg general)
  :init (setq
	 evil-want-integration t
	 evil-want-keybinding nil
	 evil-want-C-u-scroll t
	 evil-want-C-i-jump t
	 evil-flash-delay 2
	 evil-show-paren-range 5
	 evil-v$-excludes-newline t
	 ;; Error messages from motions are suppressed when they are replayed from the macro
	 evil-kbd-macro-suppress-motion-error 'replay
	 evil-respect-visual-line-mode t
	 evil-echo-state nil
	 evil-want-empty-ex-last-command nil
	 evil-undo-system 'undo-fu)
  (evil-mode 1)
  :general-config
  (:states 'normal
	   "j" 'evil-next-visual-line
	   "p" 'evil-previous-visual-line)
  (evil-insert-state-map ;; Binds to this keymap
   "C-g" 'evil-normal-state
   "C-H" 'evil-delete-backward-char-and-join)
  :config
  ;; evil-buffer-regexps can be used to set the state of a buffer matching a regex
  (evil-set-initial-state 'vterm-mode 'insert)
  (evil-set-initial-state 'messages-buffer-mode 'normal))

