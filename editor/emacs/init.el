(eval-when-compile
  (require 'use-package))

(require 'package)


(setq package-archives
      '(("melpa". "https://melpa.org/packages/"  )
        ("org"  . "https://orgmode.org/elpa/"    )
        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; For non linux
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)



(setq inhibit-startup-message t)
(setq visible-bell t)

(scroll-bar-mode -1) ;Disable visible scrollbar
(tool-bar-mode -1)   ;Disable the toolbar
(tooltip-mode -1)    ;Disable tooltips
(set-fringe-mode 10) ;Gives breathing room ?? maybe adjust
(menu-bar-mode 0)    ;the top level menu bar

(use-package all-the-icons)
(auto-revert-mode) ;; allow for the buffer to display the most accurate representation of a file

(column-number-mode) ;;collum number in modeline
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t) ;; static line numbers

;; disable line numbers for these buffer types
(dolist (mode '(org-mode-hook ;; maybe change
                nov-mode-hook)) ;; add relative line numbers when necessary
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

(use-package which-key
  :init
  (which-key-mode 1))

(use-package modus-themes
  :init
  (load-theme 'modus-vivendi 't))

(use-package helpful
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-symbol]   . helpful-symbol)
  ([remap describe-key]      . helpful-key))

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font Mono")

(setq auth-sources '("~/.authinfo.gpg"))
(setq epg-gpg-program "gpg2")

(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  :custom
  (completion-cycle-threshold 3) ;; In corfu github
  (tab-always-indent 'complete)

  ;; for emacs 30 and above
  ;; (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p))

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(use-package dash
  :config
  (with-eval-after-load 'info-look
(dash-register-info-lookup)))



(defun hyp/evil-scroll (up &optional count)
  "Move the cursor up|down count times, making sure it lands on an empty line"
  (if up
      (evil-next-line (or count 1)) 
    (evil-previous-line (or count 1)))
  (unless (looking-at-p "^[[:space:]]*$") (hyp/evil-scroll up))
  (recenter))

(defun date () 
  "Prints the current date in message buffer"
  (interactive)
  (message (calendar-date-string (calendar-current-date))))

(defun hyp/average (list)
  "Returns the average of the elements of a number list"
  (/ (float (apply '+ list)) (length list)))

(defun hyp/html-babel-src-template ()
  "Insert a template for an HTML source block in Org-mode."
  (interactive)
  (insert "#+begin_src html\n\n#+end_src")
  (forward-line -1)
  (indent-for-tab-command))

(use-package visual-fill-column)

(defun hyp-org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (visual-fill-column-mode 1)
  (setq visual-fill-column-width 175 ;; n char of writing room
	org-hierarchical-todo-statistics nil
        visual-fill-column-center-text 1))

(use-package org
  :ensure t
  :hook
  (org-mode . hyp-org-mode-setup)
  (org-mode . flyspell-mode)
  ;(org-mode . org-cdlatex-mode)
  :config
  (setq org-ellipsis " ▾")
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)  
  (setq org-fold-core-style 'overlays) 
  (setq org-checkbox-hierarchical-statistics nil)
  (setq org-todo-keywords '(
	  (sequence "TODO" "|" "DONE")
	  (sequence "REPORT" "BUG" "ISSUE" "|" "FIXED")
	  (sequence "CLASS" "|" "COMPLETED" "CANCELLED")
	  (sequence "STUDY" "|" "DONE" )
	  (sequence "EXAM" "|" "COMPLETED" )
	  (sequence "RESEARCH" "STARTED RESEARCH" "KNOWLEDGEABLE" "|" "FINISHED RESEARCH")
	  (sequence "HOMEWORK" "|" "SUBMITTED")))
  (setq org-agenda-files '(
			   "~/stuff/org/agenda/uni.org"
			   "~/stuff/org/agenda/life.org"
			   "~/stuff/org/agenda/linux.org"
			   "~/uni/CS/3/Operating_Systems_1-3413/Notes.org"
			   "~/uni/CS/3/Computer_Architecture_and_Organisation-3853/notes.org"
			   "~/uni/CS/3/Net_Centric_Computing-3873/Notes.org"
                           )))

(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")

(setq org-agenda-start-with-log-mode t) ;; create a log of tasks 
(use-package org-super-agenda)
(org-super-agenda-mode 1)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (C          . t)
   (lisp       . t)
   (java       . t)
   (sqlite     . t)
   (shell      . t)
   (lua        . t)
   (latex      . t)
   (makefile   . t)))

(setq org-confirm-babel-evaluate nil) ;; no confirmations on running code

(require 'org-tempo)

(unbind-key "C-v" org-babel-map)
(unbind-key "v" org-babel-map)

(setq org-structure-template-alist (-union org-structure-template-alist
      '(("sq" . "src sqlite") ("lx" . "src latex")
        ("ls" . "src lisp") ("ll" . "src lua")
        ("mk" . "src makefile") ("sh" . "src sh")
        ("cc" . "src C") ("jv" . "src java")
        ("el" . "src emacs-lisp"))))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/stuff/org/roam/"))

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)
         :map org-mode-map
         ("M-i" . completion-at-point))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(setq org-roam-capture-templates
      '(
        ("d" "default" plain
         "%?"
         :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
         :unnarrowed t)
        ("b" "Book" plain 
         "\nFull Name: %^{Name|${title}}\nAuthor: %^{author}\nReleased: %^{year}\nEdition: %^{edition}\nChapter Count: %^{chapters}\nPages: %^{pages}\n* Description\n\n%?\n\n* Thoughts\n\n* Links\n"
         :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
         :unnarrowed t)
        ("t" "Topic" plain
         "\n* Synopsis\n\n* %^{Main|${Main}}\n\n%?"
         :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
         :unnarrowed t)
        ("p" "Programming Concepts" plain
         "\n* Synopsis\n\n%?\n* The Theory of %^{Name}\n\n* %^{Other|Implementation in Languages|In Emacs}\n\n* References"
         :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
         :unnarrowed t)
        ("c" "UNI Course" plain 
         "\nCourse Name: %^{name}\nCourse Id: %^{id}\nSection: %^{section}\nProfessor: %^{prof}\nLecture Classroom: %^{class}\nTutorial Classroom: %^{tutorial}\nLecture Times: %^{lecturetime}\nTutorial Time: %^{time}\nCredits: $^{cred}\nTerm Taken: $^{termtime}\n\n* Index of Topics\n\n\n* Homework\n\n%?\n\n* References\n"
         :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
         :unnarrowed t)
        ))

(use-package gnuplot)

(use-package org-ql)

(use-package orgit)
(use-package orgit-forge)

(use-package magit
  :custom
  (magit-repository-directories
   '(("~/dev/git/" . 2)
     ("~/dev/proj/" . 2)
     ("~/dev/dotfiles/" . 1)
     ("~/stuff/org/" . 1)))
  :hook
  (git-commit-mode . flyspell-mode)
  )

(use-package forge
  :after magit)

(use-package git-modes
  :after magit)

(use-package auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-PDF-mode t)
  :hook
  (LaTeX-mode . turn-on-reftex))

(use-package auctex-cluttex
  :after auctex)

(use-package auto-complete-auctex
  :after auctex)

(use-package auctex-latexmk
  :after auctex)

(use-package auctex-cont-latexmk
  :after auctex-latexmk)

(use-package cdlatex)

;; (use-package eshell
;;   :hook
;;   ((eshell-mode . (lambda () (setq-local corfu-auto nil)))))

(defun my-centre-width ()
  "Return a fill column that makes centring pleasant regardless of screen size"
  (setq fill-column 100)
  (let ((window-width (window-width)))
    (floor (if (<= window-width (* 1.1 fill-column))
               (* 0.9 window-width)
             (max (/ window-width 2) fill-column)))))

(use-package nov
  :init (defun my-nov-font-setup ()
          (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                                   :height 1.3)
          (setq fill-column (my-centre-width)
                nov-text-width (- fill-column 2)
                visual-fill-column-center-text t))
  :hook ((nov-mode . my-nov-font-setup)
         (nov-mode . visual-line-mode)
         (nov-mode . visual-fill-column-mode)))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(use-package pdf-tools
  :hook
  (pdf-view-mode . (lambda () (interactive) (display-line-numbers-mode -1)))
  :init
  (pdf-loader-install))

(setf dired-kill-when-opening-new-dired-buffer t)

(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'html-mode-hook #'flyspell-mode)
(add-hook 'markdown-mode-hook #'flyspell-mode)

(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-count 25) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("C-w" . backward-kill-word))
  :init
  (vertico-mode))

;; Used for persistent hist, sugested by vertico
(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
  :custom
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-fd)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Use `consult-completion-in-region' if Vertico is enabled.
  ;; Otherwise use the default `completion--in-region' function.
  (setq completion-in-region-function
        (lambda (&rest args)
          (apply (if vertico-mode
                     #'consult-completion-in-region
                   #'completion--in-region)
                 args)))
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") )

(use-package marginalia
  :after vertico
  :ensure t
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; (use-package corfu
;;   ;; Optional customizations
;;   :custom
;;   (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
;;   (corfu-separator ?\s)          ;; Orderless field separator
;;   (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
;;   (corfu-quit-no-match t)        
;;   (corfu-preview-current nil)    ;; Disable current candidate preview
;;   (corfu-preselect 'prompt)      ;; Preselect the prompt
;;   (corfu-on-exact-match nil)     ;; Configure handling of exact matches
;;   (corfu-scroll-margin 2)        ;; Use scroll margin
;;   :config
;;   (keymap-unset corfu-map "RET")

;;   :init
;;   (global-corfu-mode))

(use-package company
  :ensure t
  :hook
  (prog-mode-hook . company-mode))

;; Use Dabbrev with Corfu!
 (use-package dabbrev
   ;; Swap M-/ and C-M-/
   :bind (("M-/" . dabbrev-completion)
          ("C-M-/" . dabbrev-expand))
   :config
   (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
   (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
   (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
   (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative keys: M-p, M-+, ...
  :hook
  (completion-at-point-functions . cape-elisp-block)
  (completion-at-point-functions . cape-file)
  (completion-at-point-functions . cape-dabbrev))

(display-time)

(use-package fireplace
  :hook
  (fireplace-mode .  fireplace--disable-minor-modes)
  :init
  (add-hook 'fireplace-mode-hook (lambda () (display-line-numbers-mode -1)))
  )

(defun hyp/evil-hook ()
  (dolist (mode '(custom-mode
                  git-rebase-mode
                  nov-mode
                  fireplace-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))


(use-package evil
  :init

  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)

  :hook (evil-mode . hyp/evil-hook)
  :init
  (evil-mode 1)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init '(calendar
                          dired
                          eshell
                          info
                          magit
                          )))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer hyp/leader-keys
    :keymaps '(normal insert visual)
    :prefix "SPC"
    :global-prefix "C-SPC"))

(use-package hydra)

(windmove-default-keybindings)

(hyp/leader-keys
  "w" 'hyp/window-hydra/body
  )

;; (hyp/leader-keys)
(which-key-add-key-based-replacements
  "SPC v" "Version Control"
  "SPC v r" "Repo Functions")

(general-define-key
 :states 'normal
 "gc" 'evilnc-comment-or-uncomment-lines
 )

(general-define-key 
 :keymaps 'pdf-view-mode-map
 "j" 'pdf-view-next-line-or-next-page
 "k" 'pdf-view-previous-line-or-previous-page
 )

(general-define-key
 :states 'normal
 :keymaps 'nov-mode-map
 "n" 'nov-next-document
 "p" 'nov-previous-document
 "j" '(lambda () (interactive) (hyp/evil-scroll t 8))
 "k" '(lambda () (interactive) (hyp/evil-scroll nil 8))
 "C-j" '(lambda () (interactive) (evil-next-line) (recenter))
 "C-k" '(lambda () (interactive) (evil-previous-line) (recenter))
 )

(general-define-key
 :keymaps 'company-active-map
 "C-j" 'company-select-next-or-abort
 "C-k" 'company-select-previous-or-abort
 "M-f" 'company-show-location
 "C-f" 'company-complete-selection
 "C-w" 'evil-delete-backward-word
 )

(general-define-key
 :states 'insert
 :keymaps 'prog-mode-map
 "<tab>" 'company-complete)

(general-define-key
 :keymap 'org-mode-map
 :prefix "C-c"
 "C-<return>" 'org-ctrl-c-ret
 )

(which-key-add-key-based-replacements
  "C-c C-v" "Babel Prefix"
  "C-c C-x" "Org Extras"
  "C-c \"" "Gnuplot Prefix"
  "C-c n" "Org Roam Prefix")

(general-define-key
 :keymaps 'org-mode-map
 :prefix "C-c C-v"
 "C-v" '(lambda () (interactive)
	(tab-new) (org-edit-special) (delete-other-windows)) 
 "v" 'org-edit-special)

(which-key-add-key-based-replacements "C-c C-v C-v" "open-src-block-in-new-tab")

(general-define-key
 :keymaps 'org-mode-map
 :prefix "C-c C-v C-<return>"
 "C-c" '(lambda ()
        (interactive)
	(insert ;; Inserts a named html block
	 (format "#+NAME: %s\n#+begin_src html :exports none\n\n#+end_src"
		 (read-string "Enter Name for Block: "))))
 "c" '(lambda ()
	  (interactive)
	  (insert ;; Insrets a babel block for html chapter export block
	   (format "#+begin_src html :exports results :noweb yes :results raw :tangle %s.html\n\n#+end_src"
			  (read-string "Enter name of HTML file: "))))
 )

(which-key-add-key-based-replacements
  "C-c C-v C-<return>" "Insert Babel Blocks"
  "C-c C-v C-<return> C-c" "Named HTML Block"
  "C-c C-v C-<return> c" "HTML Export Block")

(general-define-key
 :keymaps 'org-src-mode-map
 "C-c k" '(lambda () (interactive) (org-edit-src-exit) (tab-close))
 )

(general-define-key
 :keymaps 'org-mode-map
 :states 'insert
 "C-<" 'hyp/html-babel-src-template ;; I want to replace this with some sort of selector at some point
 "<tab>" '(lambda () (interactive) (tempo-expand-if-complete) (org-cycle));; This screws up table, make a function that does org-cycle or if tempo-complete-tag
 )

(defun hyp/insert-org-header (head)
    "Inserts HEAD as an org header"
    (interactive)
    (if (not (org-at-heading-p))
        ((funcall-interactively 'org-insert-heading-respect-content) (insert head))
      (insert head)))


  (unbind-key "C-c C-t" 'org-mode-map)
  (general-define-key
   :keymaps 'org-mode-map
   :prefix "C-c C-t"
   "<RET>" 'org-todo
   "C-<return>" 'org-todo
   "t" '(lambda () (interactive) (insert "TODO"))
   "c" '(lambda () (interactive) (insert "CLASS"))
   "a" '(lambda () (interactive) (insert "HOMEWORK"))
   "h" '(lambda () (interactive) (insert "HOMEWORK"))
   "s" '(lambda () (interactive) (insert "STUDY"))
   "e" '(lambda () (interactive) (insert "EXAM"))
   "r" '(lambda () (interactive) (insert "REPORT"))
   "C-t" '(lambda () (interactive) (insert "TODO"))
   "C-c" '(lambda () (interactive) (insert "CLASS"))
   "C-a" '(lambda () (interactive) (insert "HOMEWORK"))
   "C-h" '(lambda () (interactive) (insert "HOMEWORK"))
   "C-s" '(lambda () (interactive) (insert "STUDY"))
   "C-e" '(lambda () (interactive) (insert "EXAM"))
   "C-r" '(lambda () (interactive) (insert "REPORT")))
;; TODO move this to an org hook
  (which-key-add-key-based-replacements 
    "C-c C-t" "Todo Prefix"
    "C-c C-t t" "Insert TODO"
    "C-c C-t c" "Insert CLASS"
    "C-c C-t a" "Insert HOMEWORK"
    "C-c C-t h" "Insert HOMEWORK"
    "C-c C-t e" "Insert EXAM"
    "C-c C-t s" "Insert STUDY"
    "C-c C-t r" "Insert REPORT"
    "C-c C-t C-t" "Insert TODO"
    "C-c C-t C-c" "Insert CLASS"
    "C-c C-t C-a" "Insert HOMEWORK"
    "C-c C-t C-h" "Insert HOMEWORK"
    "C-c C-t C-e" "Insert EXAM"
    "C-c C-t C-s" "Insert STUDY"
    "C-c C-t C-r" "Insert REPORT")



(general-define-key
 :keymaps 'ctl-x-map
 "C-b" 'ibuffer
 )

(general-define-key
 :keymaps 'ibuffer-mode-map
 "j"  'evil-next-line
 "k" 'evil-previous-line)

;; (general-define-key
;;  :keymaps 'dired-mode-map
;;  :states 'normal
;;  "m" 'dired-mark
;;  )

(unbind-key "g" 'bookmark-bmenu-mode-map)
(general-define-key ; Normal Remap
 :keymaps 'bookmark-bmenu-mode-map
 "G" 'evil-goto-last-line
 "j" 'evil-next-line
 "k" 'evil-previous-line)

(general-define-key ; Old functionality goes in the g prefix
 :keymaps 'bookmark-bmenu-mode-map
 :prefix "g"
 "j" 'bookmark-bmenu-this-window
 "k" 'bookmark-bmenu-delete
 "r" 'revert-buffer
 "g" 'evil-goto-first-line)

(defhydra hydra-text-scale (:timeout 4)
    "scale text"
    ("k" text-scale-increase 1 "in")
    ("j" text-scale-decrease 1 "out")
    ("f" nil "finished" :exit t))

(defhydra hyp/window-hydra (:colour amaranth
                              :hint nil) ; warn on foreign keys?
    "
      ^Focus^         ^Move^         ^Mod Size^            ^Other^
  ^^^^^^^^-----------------------------------------------------------------
  _j_: Focus Down _J_: Move Down _s_: Increase Vert _-_: Split Horizontal  
  _k_: Focus Up   _K_: Move Up   _w_: Decrease Vert _|_: Split Vertical
  _l_: Focus ->   _L_: Move ->   _a_: Increase Hori _c_: Close
  _h_: Focus <-   _H_: Move <-   _d_: Decrease Hori _x_: Kill
"
    ("j" evil-window-down)
    ("k" evil-window-up)
    ("h" evil-window-left)
    ("l" evil-window-right)
    ("J" evil-window-move-very-top)
    ("K" evil-window-move-very-bottom)
    ("H" evil-window-move-far-left)
    ("L" evil-window-move-far-right)
    ("s" evil-window-increase-height)
    ("w" evil-window-decrease-height)
    ("a" evil-window-increase-width)
    ("d" evil-window-decrease-width)
    ("-" evil-window-split)
    ("\\" evil-window-vsplit)
    ("|" evil-window-vsplit)
    ("c" evil-window-delete)
    ("x" kill-buffer-and-window)
    ("q" nil "quit" :exit t)
    )
