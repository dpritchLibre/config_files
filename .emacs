;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; enable Emacs Lisp Package Archive
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; specify custom themes directory
(setq custom-theme-directory "~/.emacs.d/themes/")

;; specify theme
(load-theme 'blippblopp t)

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

;; ;; see https://github.com/auto-complete/auto-complete/blob/master/doc/manual.md
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)
;; ;; remove Python mode from auto-complete list of modes, since Elpy uses company
;; (setq ac-modes (delq 'python-mode ac-modes))
;; ;; prevent completion menu from showing unless M-n or M-p is used
;; (setq ac-auto-show-menu nil)


;; enable company mode in all buffers except for ESS buffers, in which we use
;; auto-complete instead
(setq company-global-modes '(not ess-mode))
(global-company-mode 1)
;; ;; enable company-mode in all buffers.  See http://company-mode.github.io
;; (add-hook 'after-init-hook 'global-company-mode)



;; enables some additional features for dired, such as omitting uninteresting
;; files (bound to C-x M-o).  See
;; https://www.gnu.org/software/emacs/manual/html_mono/dired-x.html
(require 'dired-x)

;; load Emacs Speaks Statistics
(require 'ess-site)

;; add / change keybindings.  See https://github.com/abo-abo/ace-window for
;; details regarding ace-window
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "C-M-;") 'previous-multiframe-window)
(global-set-key (kbd "C-9") 'previous-buffer)
(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "C-0") 'next-buffer)
(global-set-key (kbd "M-[") 'scroll-down-line)
(global-set-key (kbd "M-]") 'scroll-up-line)
(global-set-key (kbd "C-.") 'xref-find-definitions-other-window)

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

;; enable Icicles
(add-to-list 'load-path (expand-file-name "~/.emacs.d/icicles/"))
(require 'icicles)
(icy-mode 1)

;; use Ibuffer for Buffer List
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
	       ("Lisp" (mode . lisp-mode))
	       ("emacs" (or (mode . lisp-interaction-mode)
			    (mode . emacs-lisp-mode)))
	       ("dired" (mode . dired-mode))
	       ("processes" (or (mode . inferior-ess-mode)
				(mode . inferior-python-mode)
				(mode . term-mode)
				(mode . shell-mode)
				(mode . slime-repl-mode)))))))
(add-hook 'ibuffer-mode-hook
	  (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

;; allow color to work in shell.  See www.emacswiki.org/emacs/AnsiColor
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

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
	    (ess-toggle-S-assign nil)          ; see above comment
	    (ess-toggle-S-assign nil)          ; see above comment
	    (setq-local comment-add 0)         ; so that comments are # not ##
	    (setq ess-roxy-str "#'")           ; Roxygen comments are #' not ##'
	    (local-set-key (kbd "C-'") 'ess-switch-to-ESS)
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
	    ;; unset local keybinding.  Note that this isn't the proper way to
	    ;; do this, see the comment in
	    ;; https://stackoverflow.com/a/7598754/5518304
	    (define-key (LaTeX-mode-map "C-;" nil))
	    ))

;; ;; below doesn't work right, what can be done?
;; (setq LaTeX-fill-excluded-macros '("lstinline" "index"))


;; ;; allows synctex and preview mode to work properly together.  See
;; ;; https://tex.stackexchange.com/a/94325/88779.
;; (defadvice TeX-view (around always-view-master-file activate)
;;   (let ((TeX-current-process-region-p nil))
;;     ad-do-it))


;; magit settings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)


;; slime settings
(setq inferior-lisp-program "/usr/bin/sbcl")
;; also setup the slime-fancy contributed package
(add-to-list 'slime-contribs 'slime-fancy)

;; guile settings.  Inform guile that the only Scheme implementation currently
;; installed is mit-scheme so that it doesn't try to guess the wrong Scheme for
;; buffers.  See http://www.nongnu.org/geiser/geiser_3.html#choosing_002dimpl
(setq geiser-active-implementations '(mit))


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




;; (setq ess-use-auto-complete t)


;; end user-created section --------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auctex ace-window magit flycheck yasnippet-snippets auto-complete sqlup-mode load-theme-buffer-local zenburn-theme slime multiple-cursors geiser ess elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
