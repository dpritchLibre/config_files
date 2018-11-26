;; the following three code blocks taken from
;; http://cachestocaches.com/2015/8/getting-started-use-package/
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
;;
;; end code blocks

(load "~/Documents/Software/elisp_library/helper_functions.el")

;; ;; Added by Package.el.  This must come before configurations of
;; ;; installed packages.  Don't delete this line.  If you don't want it,
;; ;; just comment it out by adding a semicolon to the start of the line.
;; ;; You may delete these explanatory comments.
;; (package-initialize)

;; ;; enable Emacs Lisp Package Archive
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; display column number
(setq column-number-mode t)

;; set default fill column number
(setq-default fill-column 80)

;; inserting text deletes selected text
(delete-selection-mode t)

;; delete trailing whitespace when saving files
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; disable graphical toolbar at the top of the screen
(tool-bar-mode -1)

;; disable the scroll bar
(scroll-bar-mode -1)

;; send backups to `~/.emacs.d/backups` rather than saving in the same directory
;; as the file being backed up
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; dired settings
(setq-default
 dired-auto-revert-buffer t
 dired-dwim-target t
 dired-listing-switches "-alh --group-directories-first")

;; save history between Emacs instances.  From
;; http://www.wisdomandwonder.com/wp-content/uploads/2014/03/C3F.html
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; specify custom themes directory
(setq custom-theme-directory "~/.emacs.d/themes/")

;; specify theme.  See https://stackoverflow.com/a/26555466/5518304 for color
;; mods.
(load-theme 'zenburn t)
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")
;; (load-theme 'blippblopp t)

;; modeline config.  See https://github.com/tarsius/minions and
;; https://github.com/tarsius/moody
(use-package minions
  :config
  (minions-mode 1))
(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))
;; set the height of the mode line in pixels.  Default is 30.
(customize-set-value 'moody-mode-line-height 14)

;; (use-package doom-modeline
;;   :ensure t
;;   :defer t
;;   :hook (after-init . doom-modeline-init))

;; ;; enable ido.  See
;; ;; https://www.masteringemacs.org/article/introduction-to-ido-mode
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

;; ;; see https://github.com/auto-complete/auto-complete/blob/master/doc/manual.md
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)
;; ;; remove Python mode from auto-complete list of modes, since Elpy uses company
;; (setq ac-modes (delq 'python-mode ac-modes))
;; ;; prevent completion menu from showing unless M-n or M-p is used
;; (setq ac-auto-show-menu nil)


;; ;; enable company mode in all buffers except for ESS buffers, in which we use
;; ;; auto-complete instead
;; (setq company-global-modes '(not ess-mode))
;; (global-company-mode 1)

;; enable company mode in all buffers.  See http://company-mode.github.io
(add-hook 'after-init-hook 'global-company-mode)

;; enable yasnippet mode in all buffers.  See
;; https://github.com/joaotavora/yasnippet
(require 'yasnippet)
(yas-global-mode 1)
;; see https://github.com/mattfidler/r-autoyas.el
;; (require 'r-autoyas)
;; (add-hook 'ess-mode-hook 'r-autoyas-ess-activate)

;; ;; enable flycheck mode in all buffers.  See http://www.flycheck.org/en/latest/
;; (global-flycheck-mode)

;; enables some additional features for dired, such as omitting uninteresting
;; files (bound to C-x M-o).  See
;; https://www.gnu.org/software/emacs/manual/html_mono/dired-x.html
(require 'dired-x)

;; load Emacs Speaks Statistics
(setq ess-smart-S-assign-key ";")
(require 'ess-site)

;; add / change keybindings.  See https://github.com/abo-abo/ace-window for
;; details regarding ace-window
(global-set-key (kbd "M-o") 'ace-window)
;; (global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "C-M-;") 'previous-multiframe-window)
(global-set-key (kbd "C-9") 'previous-buffer)
(global-set-key (kbd "C-0") 'next-buffer)
(global-set-key (kbd "M-[") 'scroll-down-line)
(global-set-key (kbd "M-]") 'scroll-up-line)
(global-set-key (kbd "C-.") 'xref-find-definitions-other-window)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)

;; ace-window keys used for switching.  Default is 0-9.  See
;; https://github.com/abo-abo/ace-window for details regarding ace-window
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-background nil)

;; remove `C-;` keybinding for `flyspell-auto-correct-previous-word` since we
;; use it for global keybinding to 'other-window (see above keybinding
;; additions)
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-;") nil))

;; set default font size. Specifies font height in units of 1/10 pt
(set-face-attribute 'default nil :height 110)

;; cc mode tab size 4 spaces
(setq-default c-basic-offset 4)

;; so that compiler directives are properly indented
(c-set-offset (quote cpp-macro) 0 nil)

;; change comments to `//` instead of `/* ... */`
(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

;; show matching parentheses
(show-paren-mode 1)

;; default to truncate lines
(set-default 'truncate-lines t)

;; type "y" or "n" instead of "yes" or "no"
(fset 'yes-or-no-p 'y-or-n-p)

;; ;; enable Icicles
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/icicles/"))
;; (require 'icicles)
;; (icy-mode 1)

;; see `M-x describe-package RET undo-tree RET` for more details
(require 'undo-tree)
(global-undo-tree-mode)

;; see https://github.com/victorhge/iedit
(use-package iedit
  :bind
  (("C-;" . nil)
   ("C-M-i" . iedit-mode))
  )
;; (global-set-key (kbd "C-M-i") 'iedit-mode)

(use-package neotree
  :ensure t)
(require 'neotree)

;; copied from https://github.com/abo-abo/swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; see https://github.com/bbatsov/projectile and
;; https://projectile.readthedocs.io/en/latest/installation/
(use-package projectile
  :ensure t
  :config
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
(setq projectile-switch-project-action #'projectile-dired)
(setq projectile-completion-system 'ivy)
(counsel-projectile-mode)

;; see https://github.com/justbur/emacs-which-key.  A useful command is
;; `which-key-show-major-mode` (similar to `C-h m`)
(use-package which-key
  :ensure t)
(which-key-mode)
(which-key-setup-side-window-bottom)

;; from https://github.com/Wilfred/helpful/
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)
;; Look up *F*unctions (excludes macros).  By default, C-h F is bound to
;; `Info-goto-emacs-command-node`. Helpful already links to the manual, if a
;; function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)
;; Look up *C*ommands.  By default, C-h C is bound to describe
;; `describe-coding-system`. I don't find this very useful, but it's frequently
;; useful to only look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

;; use Ibuffer for Buffer List
(defun ibuffer-bury-buffer ()
  "Calls `ibuffer` and moves the buffer to the end of the buffer
list.  Doesn't work!"
  (interactive)
  (ibuffer)
  (message "Cur buf: %S" (current-buffer))
  (bury-buffer (current-buffer))
  (message "Cur buf: %S" (current-buffer)))
(global-set-key (kbd "C-x C-b") 'ibuffer-bury-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; groups Ibuffer entries.  See https://www.emacswiki.org/emacs/IbufferMode for
;; more details.
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("R" (mode . ess-mode))
	       ("Python" (mode . python-mode))
	       ("C/C++" (or (mode . c-mode)
			    (mode . c++-mode)))
	       ("LaTeX" (or (mode . latex-mode)
			    (mode . bibtex-mode)))
	       ("shell" (mode . sh-mode))
	       ("Lisp" (or (mode . lisp-mode)
			   (mode . scheme-mode)))
	       ("emacs" (or (mode . lisp-interaction-mode)
			    (mode . emacs-lisp-mode)))
	       ("dired" (mode . dired-mode))
	       ("processes" (or (mode . inferior-ess-mode)
				(mode . inferior-python-mode)
				(mode . term-mode)
				(mode . shell-mode)
				(mode . slime-repl-mode)
				(mode . geiser-repl-mode)))
	       ("Org" (mode . org-mode))))))
;; change the width of the first column.  See
;; https://emacs.stackexchange.com/a/623/15552
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 40 40 :left :elide) ; change: the two 40 values were originally 18's
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " " filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename)))
(add-hook 'ibuffer-mode-hook
	  (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

;; allow color to work in shell.  See www.emacswiki.org/emacs/AnsiColor
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; ;; setup multi-term.  See https://www.emacswiki.org/emacs/MultiTerm
;; (require 'multi-term)
;; (setq multi-term-program "/bin/bash")

;; (add-hook 'term-mode
;; 	  (lambda ()
;; 	    (define-key term-mode-map (kbd "C-j") 'term-line-mode)))

;; create function which cycles forwards through the kill ring
(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
;; bind key to previously defined function
(global-set-key (kbd "M-Y") 'yank-pop-forwards)

;; https://github.com/magnars/multiple-cursors.el
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; see https://github.com/abo-abo/avy.  Also see
;; https://cestlaz.github.io/posts/using-emacs-7-avy/ for the `use-package`
;; version of these commands.
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g M-g") 'avy-goto-line)

;; save clock history across Emacs sessions.  See
;; https://orgmode.org/manual/Clocking-work-time.html
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
;; add languages to babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)))
;; no need for confirmation before evaluating code blocks
(setq org-confirm-babel-evaluate nil)
;; inserting graphical output
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)

;; see docstring for `org-latex-listings`
(setq org-latex-listings t)
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-default-packages-alist '("\\PassOptionsToPackage{hyphens}{url}" "" ""))

;; Org mode by default adds a `\hypersetup` section, but setting this variable
;; prevents the automatic addition so that we can define our own
(customize-set-value 'org-latex-with-hyperref nil)

;; ;; ;; automatically sudo if needed for file permissions.  See
;; ;; ;; http://emacsredux.com/blog/2013/04/21/edit-files-as-root/
;; ;; (defadvice find-file (after find-file-sudo activate)
;; ;;   "Find file as root if necessary."
;; ;;   (unless (and buffer-file-name
;; ;;                (file-writable-p buffer-file-name))
;; ;;     (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; ESS hook additions.  Note that the duplicate calls to (ess-toggle-S-assign
;; nil) are correct: the first call clears the default `ess-smart-S-assign'
;; assignment and the second line re-assigns it to the customized setting.
(add-hook 'ess-mode-hook
	  (lambda ()
	    (ess-set-style 'C++ 'quiet)        ; recommended in R Internals man
	    (setq ess-fancy-comments nil)      ; disable ESS-style indentation
	    (setq ess-smart-S-assign-key ";")  ; reassign ' <- ' to ';'
	    ;; (ess-toggle-S-assign nil)          ; removed due to https://stackoverflow.com/q/50954945
	    ;; (ess-toggle-S-assign nil)          ; see above comment
	    (setq-local comment-add 0)         ; so that comments are # not ##
	    (setq ess-roxy-str "#'")           ; Roxygen comments are #' not ##'
	    ;; (local-set-key (kbd "C-'") 'ess-switch-to-ESS)
	    (local-set-key (kbd "C-S-m") (lambda () (interactive) (insert " %>% ")))
	    (setq inferior-R-args "--no-restore-history --no-save ")
	    ;; (add-hook 'local-write-file-hooks
	    ;; 	      (lambda ()
	    ;; 		(ess-nuke-trailing-whitespace)))
	    (setq ess-swv-processor 'knitr)                 ; weaver
	    (setq ess-swv-pdflatex-commands '("pdflatex"))  ; LaTeX compiler
	    (setq ess-nuke-trailing-whitespace-p t)         ; strip trailing whitespace w/o query
	    (setq ess-sas-local-unix-keys t)                ; SAS keys, see section 13.5
	    ))

;; note: use `R-initialize-on-start` when the documentation isn't working.  See
;; https://github.com/emacs-ess/ESS/issues/117

;; customize comint (command interpreter) settings, as described in the ESS
;; manual, section 4.3
(eval-after-load "comint"
   '(progn
      (define-key comint-mode-map [up]
        'comint-previous-matching-input-from-input)
      (define-key comint-mode-map [down]
        'comint-next-matching-input-from-input)
      ;; also recommended for ESS use --
      (setq comint-scroll-to-bottom-on-output 'others)
      (setq comint-scroll-show-maximum-output t)
      ;; somewhat extreme, almost disabling writing in *R*, *shell* buffers above prompt:
      (setq comint-scroll-to-bottom-on-input 'this)
      ))

(use-package poly-markdown
  :ensure t)

(use-package poly-R
  :ensure t)

;; ignore text for syntax highlighting in Verbatim and lstlisting environments
;; http://tex.stackexchange.com/q/111289
;;
;; Note: I would like to put this in the LaTeX-mode hook, but it doesn't work there.  Why??
(setq LaTeX-verbatim-environments-local '("Verbatim" "lstlisting" "lstinline"))
(setq LaTeX-verbatim-macros-with-delims-local '("code"))
;; synctex minor mode additions.  See https://tex.stackexchange.com/a/49840/88779
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)  ; enable synctex minor mode
(setq TeX-source-correlate-start-server t)              ; automatically start server without asking
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
;; AUCTeX hook additions
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    ;; Enable document parsing (first two commands, see Section 1.3 in docs)
	    (setq TeX-auto-save t)
	    (setq TeX-parse-self t)
	    ;; indent after newline
	    (setq TeX-newline-function 'newline-and-indent)
	    ;; Make AUCTex aware of multi-file document structure
	    (setq-default TeX-master nil)
	    ;; ;; unset local keybinding.  Note that this isn't the proper way to
	    ;; ;; do this, see the comment in
	    ;; ;; https://stackoverflow.com/a/7598754/5518304
	    ;; (define-key (LaTeX-mode-map "C-;" nil))
	    ))

;; ;; below doesn't work right, what can be done?
;; (setq LaTeX-fill-excluded-macros '("lstinline" "index"))


;; ;; allows synctex and preview mode to work properly together.  See
;; ;; https://tex.stackexchange.com/a/94325/88779.
;; (defadvice TeX-view (around always-view-master-file activate)
;;   (let ((TeX-current-process-region-p nil))
;;     ad-do-it))

;; taken from http://pragmaticemacs.com/emacs/more-pdf-tools-tweaks/
(use-package pdf-tools
  :pin manual ;; manually update
  :config
  ;; initialise
  (pdf-tools-install)
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; use normal isearch
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  ;; more fine-grained zooming
  (setq pdf-view-resize-factor 1.1)
  ;; keyboard shortcuts
  (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete))

;; see the "Known problems" section at https://github.com/politza/pdf-tools for
;; the reason why this line is included
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)


;; magit settings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(setq git-commit-summary-max-length 50)


;; slime settings
(setq inferior-lisp-program "/usr/bin/sbcl")
;; also setup the slime-fancy contributed package
(add-to-list 'slime-contribs 'slime-fancy)
;; use quicklisp's version of slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; guile settings.  Inform guile that the only Scheme implementation currently
;; installed is mit-scheme so that it doesn't try to guess the wrong Scheme for
;; buffers.  See http://www.nongnu.org/geiser/geiser_3.html#choosing_002dimpl
(setq geiser-active-implementations '(mit))

;; `paredit` setup.  See http://wikemacs.org/wiki/Paredit-mode for details
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key)
    nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
;; see
;; https://www.reddit.com/r/emacs/comments/55rwnp/how_does_lispy_paredit_work_for_nonlisp/
;; for the following suggestion:
;;
;;     Don't use paredit in non-lisp languages. It is far too strict and you
;;     will be fighting against it most of the time. I use
;;     smartparens-strict-mode with sp-use-paredit-bindings for non-lisp and
;;     paredit for lisp.


;; Python settings
(elpy-enable)
(setq elpy-rpc-python-command "/usr/bin/python3")
(setq python-shell-interpreter (expand-file-name "~/.local/bin/ipython")
      python-shell-interpreter-args "-i --simple-prompt")

;; ;; enable autopep8 formatting on save
;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; Properly indent yanked code (not yet tested!).  From:
;;
;;    https://www.emacswiki.org/emacs/AutoIndentation#toc3
;;
;; see https://emacs.wordpress.com/2007/01/22/killing-yanking-and-copying-lines/
;; for a copying function for possible later addition
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     ess-mode        python-mode
						     c-mode          c++-mode
						     latex-mode      plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;; search for non-ascii characters in the buffer.  See
;; https://www.emacswiki.org/emacs/FindingNonAsciiCharacters
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))


;; for the MariaDB prompt to show up in the inferior process for SQL mode.  See
;; https://unix.stackexchange.com/a/297320/154101
(require 'sql)
(sql-set-product-feature 'mysql :prompt-regexp "^\\(MariaDB\\|MySQL\\) \\[[_a-zA-Z()]*\\]> ")
;; set defaults for mySQL login
(setq sql-mysql-login-params
      '((user :default "dpritch")
        (server :default "localhost")))
;; Capitalize keywords in SQL mode
(add-hook 'sql-mode-hook 'sqlup-mode)
;; Capitalize keywords in an interactive session (e.g. psql)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)
;; Set a global keyword to use sqlup on a region
(global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)


;; prepend `~/.info` to the list of directories that Emacs looks in to construct
;; the Info directory
(setq Info-directory-list
      (cons (expand-file-name "~/.info") Info-directory-list))


;; prepend directories to load path
(add-to-list 'load-path "~/.emacs.d/other-packages/yaml")


;; add yaml-mode.  See https://github.com/yoshiki/yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; bind M-y to `browse-kill-ring`.  See
;; https://github.com/browse-kill-ring/browse-kill-ring.
(browse-kill-ring-default-keybindings)




;; end user-created section --------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ec5f697561eaf87b1d3b087dd28e61a2fc9860e4c862ea8e6b0b77bd4967d0ba" "a365fc6cd465f0afb0bdde1e5f618026a15a2bea38ddf06be388ea701d0d39d8" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" default)))
 '(package-selected-packages
   (quote
    (doom-modeline which-key evil-escape evil neotree poly-R poly-markdown ivy-hydra hydra ag counsel-projectile iedit undo-tree crux projectile helpful wgrep counsel swiper ivy avy yasnippet minions solarized-theme moody browse-kill-ring zenburn haskell-mode gitignore-mode gitconfig-mode gitattributes-mode pdf-tools tablist htmlize markdown-preview-mode markdown-mode paredit auctex ace-window magit flycheck yasnippet-snippets auto-complete sqlup-mode load-theme-buffer-local zenburn-theme multiple-cursors geiser ess elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
