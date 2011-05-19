;;; -*- mode: emacs-lisp -*-

;;;_* initial packages

(defconst emacs-lisp-root "~/Library/Emacs")

(setq gnus-home-directory "~/Library/Mail/Gnus/")

;; Add other site-lisp directories, in case they were not setup by the
;; environment.

(dolist (path
         (reverse
          (list "~/Dropbox" "." "site-lisp"

                ;; Packages that bury their Lisp code in subdirectories...
                "site-lisp/eshell"
                "site-lisp/gnus/contrib"
                "site-lisp/gnus/lisp"
                "site-lisp/ess/lisp"
                "site-lisp/org-mode/contrib/lisp"
                "site-lisp/org-mode/lisp"

                "site-lisp/wanderlust/elmo"
                "site-lisp/wanderlust/wl"
                "site-lisp/wanderlust/utils"

                ;; Packages located elsewhere on the system...
                "~/Projects/ledger/lisp"
                "/opt/local/share/doc/git-core/contrib/emacs"
                )))

  (setq path (expand-file-name path emacs-lisp-root))
  (setq load-path (delete path load-path)
        load-path (delete (file-name-as-directory path) load-path))

  (when (file-directory-p path)
    (let ((default-directory path))
      (normal-top-level-add-subdirs-to-load-path)
      (add-to-list 'load-path path))))

(load "autoloads" t)

;; Read in the Mac's global environment settings.

(let ((plist (expand-file-name "~/.MacOSX/environment.plist")))
  (when (file-readable-p plist)
    (let ((dict (cdr (assq 'dict (cdar (xml-parse-file plist))))))
      (while dict
	(when (and (listp (car dict)) (eq 'key (caar dict)))
	  (setenv (car (cddr (car dict)))
		  (car (cddr (car (cddr dict))))))
	(setq dict (cdr dict))))
    (setq exec-path nil)
    (mapc #'(lambda (path) (add-to-list 'exec-path path))
          (nreverse (split-string (getenv "PATH") ":")))))

;; Set the *Message* log to something higher

(setq message-log-max 2048)

;;;_* customizations

;;;_ + variables

(load "initsplit")

(put 'set-goal-column 'disabled nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(after-save-hook (quote (executable-make-buffer-file-executable-if-script-p)))
 '(align-c++-modes (quote (csharp-mode c++-mode c-mode java-mode groovy-mode)))
 '(align-to-tab-stop nil)
 '(auto-compression-mode t nil (jka-compr))
 '(auto-image-file-mode t)
 '(auto-save-interval 1024)
 '(backup-directory-alist (quote (("/Volumes/Files/" . "/Volumes/Files/.backups") (".*recentf.*" . "/tmp") (".*" . "~/.emacs.d/backups"))))
 '(backward-delete-char-untabify-method (quote untabify))
 '(bookmark-save-flag 1)
 '(browse-url-browser-function (quote (("\\.\\(gz\\|tgz\\|bz2\\|tbz\\|dmg\\|iso\\|pdf\\|mp3\\)\\'" . browse-url-download-file) (".*" . browse-url-default-macosx-browser))))
 '(c-default-style (quote ((java-mode . "gnu") (awk-mode . "awk") (other . "gnu"))))
 '(circe-ignore-list (quote ("jordanb_?")))
 '(clean-buffer-list-kill-regexps (quote (".*")))
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(completion-ignored-extensions (quote (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".dvi" ".fmt" ".tfm" ".pdf" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".xfasl" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo")))
 '(confluence-save-credentials t)
 '(confluence-url "https://portal/wiki/rpc/xmlrpc" t)
 '(current-language-environment "UTF-8")
 '(custom-buffer-done-function (quote kill-buffer))
 '(custom-raised-buttons nil)
 '(cycbuf-buffer-sort-function (quote cycbuf-sort-by-recency))
 '(cycbuf-clear-delay 2)
 '(cycbuf-dont-show-regexp (quote ("^ " "^\\*cycbuf\\*$" "^\\*")))
 '(cycbuf-file-name-replacements (quote (("/Users/Sergey/" "~/"))))
 '(cycbuf-max-window-height 10)
 '(default-frame-alist (quote ((font . "-apple-courier-medium-r-normal--15-0-72-72-m-0-iso10646-1") (cursor-color . "#b247ee"))))
 '(default-input-method "latin-1-prefix")
 '(default-major-mode (quote fundamental-mode) t)
 '(delete-by-moving-to-trash t)
 '(delete-old-versions (quote none))
 '(directory-free-space-args "-kh")
 '(dired-guess-shell-gnutar "tar")
 '(dired-listing-switches "-lh")
 '(dired-load-hook (quote ((lambda nil (load "dired-x")))))
 '(dired-no-confirm (quote (byte-compile chgrp chmod chown copy hardlink symlink touch)))
 '(dired-omit-mode nil t)
 '(dired-recursive-copies (quote always))
 '(dired-recursive-deletes (quote always))
 '(display-time-mode t)
 '(elmo-imap4-default-authenticate-type (quote clear) t)
 '(elmo-imap4-default-port 993 t)
 '(elmo-imap4-default-server "mail.newartisans.com" t)
 '(elmo-imap4-default-stream-type (quote ssl) t)
 '(elscreen-display-tab nil)
 '(elscreen-prefix-key "")
 '(emacs-lisp-mode-hook (quote (turn-on-auto-fill eldoc-mode (lambda nil (local-set-key [(meta 46)] (quote find-function)) (local-set-key [(control 109)] (quote newline-and-indent))))))
 '(enable-recursive-minibuffers t)
 '(eshell-history-size 1000)
 '(eshell-ls-dired-initial-args (quote ("-h")))
 '(eshell-ls-exclude-regexp "~\\'")
 '(eshell-ls-initial-args "-h")
 '(eshell-modules-list (quote (eshell-alias eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script eshell-smart eshell-term eshell-unix eshell-xtra)))
 '(eshell-prefer-to-shell t nil (eshell))
 '(eshell-prompt-function (lambda nil (concat (abbreviate-file-name (eshell/pwd)) (if (= (user-uid) 0) " # " " $ "))))
 '(eshell-save-history-on-exit t)
 '(eshell-stringify-t nil)
 '(eshell-term-name "ansi")
 '(eshell-visual-commands (quote ("vi" "top" "screen" "less" "lynx" "ssh" "rlogin" "telnet")))
 '(eval-expr-print-function (quote pp) t)
 '(exec-path (quote ("/Applications/MacPorts/Emacs.app/Contents/MacOS/bin" "/Users/Sergey/bin" "/usr/local/bin" "/opt/local/libexec/git-core" "/opt/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/opt/local/sbin" "/usr/sbin" "/sbin" "/usr/X11R6/bin")))
 '(fill-column 78)
 '(flyspell-abbrev-p nil)
 '(flyspell-incorrect-hook (quote (flyspell-maybe-correct-transposition)))
 '(focus-follows-mouse t)
 '(font-lock-support-mode (quote jit-lock-mode))
 '(frame-title-format (quote (:eval (if buffer-file-name default-directory "%b"))) t)
 '(global-auto-revert-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(haskell-check-command "~/.cabal/bin/hlint")
 '(haskell-mode-hook (quote (turn-on-haskell-indentation turn-on-font-lock turn-on-eldoc-mode turn-on-haskell-doc-mode turn-on-haskell-decl-scan my-haskell-mode-hook)))
 '(haskell-program-name "ghci")
 '(haskell-saved-check-command "~/.cabal/bin/hlint" t)
 '(ibuffer-expert t)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 16 -1) " " (size 6 -1 :right) " " (mode 16 16) " " filename) (mark " " (name 16 -1) " " filename))))
 '(ibuffer-maybe-show-regexps nil)
 '(ibuffer-shrink-to-minimum-size t t)
 '(ibuffer-use-other-window t)
 '(ido-auto-merge-work-directories-length 0)
 '(ido-cannot-complete-command (quote ido-exit-minibuffer))
 '(ido-decorations (quote ("{" "}" "," ",..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
 '(ido-enable-flex-matching t)
 '(ido-ignore-files (quote ("\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./" "\\`\\.DS_Store" "\\`\\.localized" "\\.sparsebundle/" "\\.dmg\\'")))
 '(ido-mode (quote both) nil (ido))
 '(ido-use-filename-at-point nil)
 '(ido-use-virtual-buffers t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-echo-area-message "Sergey")
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((top . 25) (left . 515) (width . 100) (height . 76))))
 '(initsplit-customizations-alist (quote (("\\`\\(canlock\\|eudc\\|spam\\|nnmail\\|nndraft\\|mm\\|message\\|mail\\|gnus\\|sendmail\\|send-mail\\|starttls\\|smtpmail\\|check-mail\\)-" "~/Library/Emacs/.gnus.el" nil) ("\\`\\(org\\|calendar\\|diary\\)-" "~/Library/Emacs/.org.el" nil))))
 '(kill-whole-line t)
 '(large-file-warning-threshold nil)
 '(ledger-file "~/Dropbox/Accounts/ledger.dat")
 '(ledger-post-use-ido t)
 '(line-number-mode t)
 '(line-spacing 2)
 '(lui-time-stamp-position nil)
 '(mac-pass-command-to-system nil)
 '(mac-pass-control-to-system nil)
 '(magit-process-popup-time 15)
 '(magit-push-script "/Users/Sergey/bin/push")
 '(mark-holidays-in-calendar t)
 '(next-line-add-newlines nil)
 '(nnimap-dont-close nil)
 '(ns-alternate-modifier (quote alt))
 '(ns-command-modifier (quote meta))
 '(nxml-sexp-element-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(parens-require-spaces t)
 '(pcomplete-compare-entries-function (quote file-newer-than-file-p))
 '(ps-font-size (quote (8 . 10)))
 '(ps-footer-font-size (quote (12 . 14)))
 '(ps-header-font-size (quote (12 . 14)))
 '(ps-header-title-font-size (quote (14 . 16)))
 '(ps-line-number-font-size 10)
 '(ps-print-color-p nil)
 '(python-check-command "epylint")
 '(rcirc-track-minor-mode t)
 '(read-buffer-function (quote ido-read-buffer))
 '(recentf-auto-cleanup 600)
 '(recentf-exclude (quote ("~\\'" "\\`out\\'" "\\.log\\'" "^/[^/]*:")))
 '(recentf-max-saved-items 200)
 '(recentf-mode t)
 '(regex-tool-backend (quote perl))
 '(require-final-newline (quote ask))
 '(safe-local-variable-values (quote ((after-save-hook archive-done-tasks) (after-save-hook sort-done-tasks) (after-save-hook commit-after-save))))
 '(session-globals-exclude (quote (load-history flyspell-auto-correct-ring)))
 '(session-registers (quote (t (0 . 127))))
 '(show-paren-delay 0)
 '(show-paren-mode (quote paren))
 '(slime-kill-without-query-p t)
 '(slime-startup-animation nil)
 '(sql-sqlite-program "sqlite3")
 '(sr-window-split-style (quote vertical))
 '(ssl-certificate-verification-policy 1)
 '(svn-status-hide-unmodified t)
 '(tags-apropos-verbose t)
 '(tags-case-fold-search nil)
 '(temp-buffer-resize-mode t nil (help))
 '(text-mode-hook (quote (auto-fill-mode)))
 '(tool-bar-mode nil)
 '(tramp-verbose 3)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(user-full-name "Sergey Kutserubov")
 '(user-init-file "/Users/Sergey/Library/Emacs/.emacs.el" t)
 '(user-initials "jww")
 '(user-mail-address "sergey@sergeyk.com")
 '(vc-follow-symlinks t)
 '(vc-handled-backends (quote (GIT)))
 '(version-control t)
 '(visible-bell t)
 '(whitespace-auto-cleanup t)
 '(whitespace-rescan-timer-time nil)
 '(whitespace-silent t)
 '(winner-mode t nil (winner))
 '(wl-temporary-file-directory "/tmp/")
 '(x-select-enable-clipboard t)
 '(x-stretch-cursor t)
 '(zencoding-preview-default nil))

;;;_ + faces

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(circe-highlight-all-nicks-face ((t (:foreground "dark blue"))))
 '(circe-originator-face ((t (:foreground "dark orange"))))
 '(diff-added ((t (:foreground "DarkGreen"))))
 '(diff-added2 ((t (:foreground "SeaGreen"))))
 '(diff-changed ((t (:foreground "MediumBlue"))))
 '(diff-context ((t (:foreground "Black"))))
 '(diff-file-header ((t (:foreground "White" :background "Gray50"))))
 '(diff-header ((t (:foreground "Blue"))))
 '(diff-hunk-header ((t (:foreground "Salmon" :background "Gray90"))))
 '(diff-index ((t (:foreground "Green"))))
 '(diff-nonexistent ((t (:foreground "DarkBlue"))))
 '(diff-removed ((t (:foreground "Red"))))
 '(diff-removed2 ((t (:foreground "Orange"))))
 '(font-lock-comment-face ((((class color)) (:foreground "firebrick"))))
 '(ledger-register-pending-face ((t (:weight bold))))
 '(magit-branch-face ((((class color) (background light)) (:foreground "Blue"))))
 '(magit-diff-none-face ((((class color) (background light)) (:foreground "grey50"))))
 '(slime-highlight-edits-face ((((class color) (background light)) (:background "gray98"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "light salmon")))))

;;;_ + disabled commands

(put 'eval-expression  'disabled nil)   ; Let ESC-ESC work
(put 'narrow-to-region 'disabled nil)   ; Let narrowing work
(put 'narrow-to-page   'disabled nil)   ; Let narrowing work
(put 'upcase-region    'disabled nil)   ; Let downcasing work
(put 'downcase-region  'disabled nil)   ; Let upcasing work
(put 'erase-buffer     'disabled nil)

;;;_* packages

(mapc #'load (directory-files (expand-file-name "lang" emacs-lisp-root)
                              t "\\.el$" t))

;;;_ + direct loads

(mapc #'(lambda (name) (load name t))
      '(;;"archive-region"
        ;;"bookmark+"
        "browse-kill-ring+"
        ;;"chess-auto"
        ;;"diff-mode-"
        "diminish"
        ;;"elscreen"
        "escreen"
        "ess-site"
        "flyspell-ext"
        "gist"
        "ldg-new"
        "magit"
        "magit-topgit"
        "rebase-mode"
        "session"
        "whitespace"
        "yasnippet"
        ))

;;;_ + auto loads

(mapc #'(lambda (entry) (autoload (cdr entry) (car entry) nil t))
      '(("linum"             . linum-mode)
        ("delim-kill"        . delim-kill)
        ("cycbuf"            . cycbuf-switch-to-next-buffer)
        ("cycbuf"            . cycbuf-switch-to-previous-buffer)
        ("goby"              . goby)
        ("sunrise-commander" . sunrise)
        ("column-marker"     . column-marker-1)
        ))

(eval-after-load "sunrise-commander"
  '(progn
     (load "sunrise-x-modeline")
     (load "sunrise-x-tree")))

;;;_ + elscreen

(eval-after-load "elscreen"
  '(progn
     (define-key elscreen-map "\C-\\" 'elscreen-toggle)
     (define-key elscreen-map "\\"    'toggle-input-method)))

(eval-after-load "escreen"
  '(progn
     (escreen-install)
     (define-key escreen-map "\\" 'toggle-input-method)

     (defvar escreen-e21-mode-line-string "[0]")
     (defun escreen-e21-mode-line-update ()
       (setq escreen-e21-mode-line-string
             (format "[%d]" escreen-current-screen-number))
       (force-mode-line-update))

     (let ((point (or
                   ;; GNU Emacs 21.3.50 or later
                   (memq 'mode-line-position mode-line-format)
                   ;; GNU Emacs 21.3.1
                   (memq 'mode-line-buffer-identification mode-line-format)))
           (escreen-mode-line-elm '(t (" " escreen-e21-mode-line-string))))
       (when (null (member escreen-mode-line-elm mode-line-format))
         (setcdr point (cons escreen-mode-line-elm (cdr point)))))

     (add-hook 'escreen-goto-screen-hook 'escreen-e21-mode-line-update)))

;;;_  + eshell

(load "esh-toggle" t)

(eval-after-load "em-unix"
  '(unintern 'eshell/rm))

;;;_ + git

(setenv "GIT_PAGER" "")

(setq github-username "jwiegley"
      github-api-key "14c811944452528f94a5b1e3488487cd")

(defun commit-after-save ()
  (let ((file (file-name-nondirectory (buffer-file-name))))
    (message "Committing changes to Git...")
    (if (= 0 (shell-command
	      (format "git add \"%s\" ; git commit -m \"changes to %s\""
		      file file)))
	(message "Committed changes to %s" file)
      (message "NO changes saved for %s" file))))

(eval-after-load "dired-x"
  '(progn
     (defvar dired-omit-regexp-orig (symbol-function 'dired-omit-regexp))

     (require 'wdired)
     (define-key dired-mode-map [?r] 'wdired-change-to-wdired-mode)

     (defun dired-omit-regexp ()
       (let ((file (expand-file-name ".git"))
	     parent-dir)
	 (while (and (not (file-exists-p file))
		     (progn
		       (setq parent-dir
			     (file-name-directory
			      (directory-file-name
			       (file-name-directory file))))
		       ;; Give up if we are already at the root dir.
		       (not (string= (file-name-directory file)
				     parent-dir))))
	   ;; Move up to the parent dir and try again.
	   (setq file (expand-file-name ".git" parent-dir)))
	 ;; If we found a change log in a parent, use that.
	 (if (file-exists-p file)
	     (let ((regexp (funcall dired-omit-regexp-orig))
		   (omitted-files (shell-command-to-string
				   "git clean -d -x -n")))
	       (if (= 0 (length omitted-files))
		   regexp
		 (concat
		  regexp
		  (if (> (length regexp) 0)
		      "\\|" "")
		  "\\("
		  (mapconcat
		   #'(lambda (str)
		       (concat "^"
			       (regexp-quote
				(substring str 13
					   (if (= ?/ (aref str (1- (length str))))
					       (1- (length str))
					     nil)))
			       "$"))
		   (split-string omitted-files "\n" t)
		   "\\|")
		  "\\)")))
	   (funcall dired-omit-regexp-orig))))

     (defun dired-delete-file (file &optional recursive)
       (if recursive
	   (call-process "/Users/Sergey/bin/del" nil nil nil "-fr" file)
	 (call-process "/Users/Sergey/bin/del" nil nil nil file)))))

(eval-after-load "magit"
  '(add-hook 'magit-log-edit-mode-hook
             (function
              (lambda ()
                (set-fill-column 72)
                (column-number-mode t)
                (column-marker-1 72)))))

;;;_ + mule

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(defun normalize-file ()
  (interactive)
  (set-buffer-file-coding-system 'unix)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\r$" nil t)
      (replace-match "")))
  (set-buffer-file-coding-system 'utf-8)
  (untabify (point-min) (point-max))
  (let ((require-final-newline t))
    (save-buffer)))

;;;_ + session

(eval-after-load "session"
  '(progn
     (add-hook 'after-init-hook 'session-initialize)

     (defun save-information ()
       (dolist (func kill-emacs-hook)
         (unless (eq func 'exit-gnus-on-exit)
           (funcall func))))

     (run-with-idle-timer 900 t 'save-information)))


(eval-after-load "whitespace"
  '(progn
     (remove-hook 'find-file-hooks 'whitespace-buffer)
     (remove-hook 'kill-buffer-hook 'whitespace-buffer)

     (add-hook 'find-file-hooks 'maybe-turn-on-whitespace t)

     (defun maybe-turn-on-whitespace ()
       "Depending on the file, maybe turn on `whitespace-mode'."
       (let ((file (expand-file-name ".clean"))
             parent-dir)
         (while (and (not (file-exists-p file))
                     (progn
                       (setq parent-dir
                             (file-name-directory
                              (directory-file-name
                               (file-name-directory file))))
                       ;; Give up if we are already at the root dir.
                       (not (string= (file-name-directory file)
                                     parent-dir))))
           ;; Move up to the parent dir and try again.
           (setq file (expand-file-name ".clean" parent-dir)))
         ;; If we found a change log in a parent, use that.
         (when (and (file-exists-p file)
                    (not (file-exists-p ".noclean"))
                    (not (and buffer-file-name
                              (string-match "\\.texi$" buffer-file-name))))
           (add-hook 'write-contents-hooks
                     #'(lambda ()
                         (ignore (whitespace-buffer))) nil t)
           (whitespace-buffer))))))

;;;_ + yasnippet

(eval-after-load "yasnippet"
  '(progn
     (yas/initialize)
     (yas/load-directory (expand-file-name "snippets/" emacs-lisp-root))))

;;;_ + diminish

(eval-after-load "diminish"
  '(progn
     (diminish 'abbrev-mode)
     (diminish 'auto-fill-function)
     (ignore-errors
       (diminish 'yas/minor-mode))

     
(defadvice dired-omit-startup (after diminish-dired-omit activate)
       "Make sure to remove \"Omit\" from the modeline."
       (diminish 'dired-omit-mode))

     (eval-after-load "dot-mode" '(diminish 'dot-mode))
     (eval-after-load "eldoc"    '(diminish 'eldoc-mode))
     (eval-after-load "winner"   '(ignore-errors (diminish 'winner-mode)))))

;;;_* keybindings

;;;_ + global

(define-key global-map [(control meta backspace)] 'backward-kill-sexp)
(define-key global-map [(control meta delete)]    'backward-kill-sexp)

(defun smart-beginning-of-line (&optional arg)
  (interactive "p")
  (let ((here (point)))
    (beginning-of-line-text arg)
    (if (= here (point))
	(beginning-of-line arg))))

(define-key global-map [(control ?.)] 'smart-beginning-of-line)

(defun tidy-xml-buffer ()
  (interactive)
  (save-excursion
    (call-process-region (point-min) (point-max) "tidy" t t nil
			 "-xml" "-i" "-wrap" "0" "-omit" "-q")))

(define-key global-map [(control shift ?h)] 'tidy-xml-buffer)

(defun isearch-backward-other-window ()
  (interactive)
  (split-window-vertically)
  (call-interactively 'isearch-backward))

(define-key global-map [(control meta ?r)] 'isearch-backward-other-window)

(defun isearch-forward-other-window ()
  (interactive)
  (split-window-vertically)
  (call-interactively 'isearch-forward))

(define-key global-map [(control meta ?s)] 'isearch-forward-other-window)

(defun collapse-or-expand ()
  (interactive)
  (if (> (length (window-list)) 1)
      (delete-other-windows)
    (bury-buffer)))

(define-key global-map [(control ?z)] 'collapse-or-expand)

(define-key global-map [(control meta ?w)] 'delim-kill)

(defun delete-indentation-forward ()
  (interactive)
  (delete-indentation t))

(define-key global-map [(meta ?j)] 'delete-indentation-forward)
(define-key global-map [(meta ?J)] 'delete-indentation)

(defun keep-mine ()
  (interactive)
  (beginning-of-line)
  (assert (or (looking-at "<<<<<<")
              (re-search-backward "^<<<<<<" nil t)
              (re-search-forward "^<<<<<<" nil t)))
  (goto-char (match-beginning 0))
  (let ((beg (point)))
    (forward-line)
    (delete-region beg (point))
    (re-search-forward "^=======")
    (setq beg (match-beginning 0))
    (re-search-forward "^>>>>>>>")
    (forward-line)
    (delete-region beg (point))))

(defun keep-theirs ()
  (interactive)
  (beginning-of-line)
  (assert (or (looking-at "<<<<<<")
              (re-search-backward "^<<<<<<" nil t)
              (re-search-forward "^<<<<<<" nil t)))
  (goto-char (match-beginning 0))
  (let ((beg (point)))
    (re-search-forward "^=======")
    (forward-line)
    (delete-region beg (point))
    (re-search-forward "^>>>>>>>")
    (beginning-of-line)
    (setq beg (point))
    (forward-line)
    (delete-region beg (point))))

(define-key global-map [(meta ?n)] 'keep-theirs)
(define-key global-map [(meta ?p)] 'keep-mine)

(defun refill-ti-comment ()
  (interactive)
  (save-excursion
    (goto-char (line-beginning-position))
    (let ((begin (point)) end
          (marker ?-) (marker-re "\\(-----\\|\\*\\*\\*\\*\\*\\)")
          (leader-width 0))
      (unless (looking-at "[ \t]*/\\*[-* ]")
        (search-backward "/*")
        (goto-char (line-beginning-position)))
      (unless (looking-at "[ \t]*/\\*[-* ]")
        (error "Not in a comment"))
      (while (and (looking-at "\\([ \t]*\\)/\\* ")
                  (setq leader-width (length (match-string 1)))
                  (not (looking-at (concat "[ \t]*/\\*" marker-re))))
        (forward-line -1)
        (setq begin (point)))
      (when (looking-at (concat "[^\n]+?" marker-re "\\*/[ \t]*$"))
        (setq marker (if (string= (match-string 1) "-----") ?- ?*))
        (forward-line))
      (while (and (looking-at "[^\n]+?\\*/[ \t]*$")
                  (not (looking-at (concat "[^\n]+?" marker-re
                                           "\\*/[ \t]*$"))))
        (forward-line))
      (when (looking-at (concat "[^\n]+?" marker-re "\\*/[ \t]*$"))
        (forward-line))
      (setq end (point))
      (let ((comment (buffer-substring-no-properties begin end)))
        (with-temp-buffer
          (insert comment)
          (goto-char (point-min))
          (flush-lines (concat "^[ \t]*/\\*" marker-re "[-*]+\\*/[ \t]*$"))
          (goto-char (point-min))
          (while (re-search-forward "^[ \t]*/\\* ?" nil t)
            (goto-char (match-beginning 0))
            (delete-region (match-beginning 0) (match-end 0)))
          (goto-char (point-min))
          (while (re-search-forward "[ \t]*\\*/[ \t]*$" nil t)
            (goto-char (match-beginning 0))
            (delete-region (match-beginning 0) (match-end 0)))
          (goto-char (point-min)) (delete-trailing-whitespace)
          (goto-char (point-min)) (flush-lines "^$")
          (set-fill-column (- 80         ; width of the text
                              6          ; width of "/*  */"
                              leader-width))
          (goto-char (point-min)) (fill-paragraph)
          (goto-char (point-min))
          (while (not (eobp))
            (insert (make-string leader-width ? ) "/* ")
            (goto-char (line-end-position))
            (insert (make-string (- 80 3 (current-column)) ? ) " */")
            (forward-line))
          (goto-char (point-min))
          (insert (make-string leader-width ? )
                  "/*" (make-string (- 80 4 leader-width) marker) "*/\n")
          (goto-char (point-max))
          (insert (make-string leader-width ? )
                  "/*" (make-string (- 80 4 leader-width) marker) "*/\n")
          (setq comment (buffer-string)))
        (goto-char begin)
        (delete-region begin end)
        (insert comment)))))

(define-prefix-command 'lisp-find-map)
(define-key global-map [(control ?h) ?e] 'lisp-find-map)
(define-key lisp-find-map [?a] 'apropos)
(define-key lisp-find-map [?e] 'view-echo-area-messages)
(define-key lisp-find-map [?f] 'find-function)
(define-key lisp-find-map [?v] 'find-variable)
(define-key lisp-find-map [?k] 'find-function-on-key)

(define-key global-map [(meta ?G)] 'gnus)
(define-key global-map [(meta ?N)] 'winner-redo)
(define-key global-map [(meta ?P)] 'winner-undo)
(define-key global-map [(meta ?T)] 'tags-search)

(define-key global-map [(meta ?\')] 'insert-pair)
(define-key global-map [(meta ?\")] 'insert-pair)

(defun align-code (beg end &optional arg)
  (interactive "rP")
  (if (null arg)
      (align beg end)
    (let ((end-mark (copy-marker end)))
      (indent-region beg end-mark nil)
      (align beg end-mark))))

(define-key global-map [(meta ?\[)] 'align-code)
(define-key global-map [(meta ?!)]  'eshell-command)
(define-key global-map [(meta ?`)]  'other-frame)
;;(define-key global-map [(meta ?`)]  'cycbuf-switch-to-next-buffer)
;;(define-key global-map [(meta ?~)]  'cycbuf-switch-to-previous-buffer)

(define-key global-map [(alt ?`)]  'other-frame)

(defun mark-line (&optional arg)
  (interactive "p")
  (beginning-of-line)
  (let ((here (point)))
    (dotimes (i arg)
      (end-of-line))
    (set-mark (point))
    (goto-char here)))

(defun mark-sentence (&optional arg)
  (interactive "P")
  (backward-sentence)
  (mark-end-of-sentence arg))

(define-key global-map [(meta shift ?w)] 'mark-word)
(define-key global-map [(meta shift ?l)] 'mark-line)
(define-key global-map [(meta shift ?s)] 'mark-sentence)
(define-key global-map [(meta shift ?x)] 'mark-sexp)
(define-key global-map [(meta shift ?b)] 'python-mark-block)
(define-key global-map [(meta shift ?h)] 'mark-paragraph)
(define-key global-map [(meta shift ?d)] 'mark-defun)

(define-key global-map [(control return)] 'other-window)

(define-key global-map [f5] 'gud-cont)
(define-key global-map [f10] 'gud-next)
(define-key global-map [f11] 'gud-step)
(define-key global-map [(shift f11)] 'gud-finish)

(define-key global-map [(alt ?v)] 'scroll-down)
(define-key global-map [(meta ?v)] 'yank)

(define-key global-map [(alt tab)]
  #'(lambda ()
      (interactive)
      (call-interactively (key-binding (kbd "M-TAB")))))

;;;_ + ctl-x

(define-key ctl-x-map [?d] 'delete-whitespace-rectangle)
(define-key ctl-x-map [?g] 'magit-status)
(define-key ctl-x-map [?t] 'toggle-truncate-lines)

(defun unfill-paragraph (arg)
  (interactive "*p")
  (let (beg end)
    (forward-paragraph arg)
    (setq end (copy-marker (- (point) 2)))
    (backward-paragraph arg)
    (if (eolp)
	(forward-char))
    (setq beg (point-marker))
    (when (> (count-lines beg end) 1)
      (while (< (point) end)
	(goto-char (line-end-position))
	(let ((sent-end (memq (char-before) '(?. ?\; ?! ??))))
	  (delete-indentation 1)
	  (if sent-end
	      (insert ? )))
	(end-of-line))
      (save-excursion
	(goto-char beg)
	(while (re-search-forward "[^.;!?:]\\([ \t][ \t]+\\)" end t)
	  (replace-match " " nil nil nil 1))))))

(defun unfill-region (beg end)
  (interactive "r")
  (setq end (copy-marker end))
  (save-excursion
    (goto-char beg)
    (while (< (point) end)
      (unfill-paragraph 1)
      (forward-paragraph))))

(defun refill-paragraph (arg)
  (interactive "*P")
  (let ((fun (if (memq major-mode '(c-mode c++-mode))
		 'c-fill-paragraph
	       (or fill-paragraph-function
		   'fill-paragraph)))
	(width (if (numberp arg) arg))
	prefix beg end)
    (forward-paragraph 1)
    (setq end (copy-marker (- (point) 2)))
    (forward-line -1)
    (let ((b (point)))
      (skip-chars-forward "^A-Za-z0-9`'\"(")
      (setq prefix (buffer-substring-no-properties b (point))))
    (backward-paragraph 1)
    (if (eolp)
	(forward-char))
    (setq beg (point-marker))
    (delete-horizontal-space)
    (while (< (point) end)
      (delete-indentation 1)
      (end-of-line))
    (let ((fill-column (or width fill-column))
	  (fill-prefix prefix))
      (if prefix
	  (setq fill-column
		(- fill-column (* 2 (length prefix)))))
      (funcall fun nil)
      (goto-char beg)
      (insert prefix)
      (funcall fun nil)
      (if (memq major-mode '(c-mode c++-mode))
	  (c-recomment-region beg (+ end 2))))
    (goto-char (+ end 2))))

(define-key ctl-x-map [(meta ?q)] 'refill-paragraph)
(define-key mode-specific-map [(meta ?q)] 'unfill-paragraph)

(if (functionp 'ibuffer)
    (define-key ctl-x-map [(control ?b)] 'ibuffer)
  (define-key ctl-x-map [(control ?b)] 'list-buffers))

(defun duplicate-line ()
  "Duplicate the line containing point."
  (interactive)
  (save-excursion
    (let (line-text)
      (goto-char (line-beginning-position))
      (let ((beg (point)))
        (goto-char (line-end-position))
        (setq line-text (buffer-substring beg (point))))
      (if (eobp)
          (insert ?\n)
        (forward-line))
      (open-line 1)
      (insert line-text))))

(define-key ctl-x-map [(control ?d)] 'duplicate-line)

(autoload 'esh-toggle "esh-toggle" nil t)

(define-key ctl-x-map [(control ?z)] 'eshell-toggle)

;;;_ + mode-specific

(defun toggle-code-file (&optional arg)
  (interactive "p")
  (let* ((path (buffer-file-name))
         (base (file-name-sans-extension path)))
    (cond ((string-match "\\.as[cphma]x\\'" path)
           (find-file (concat path ".cs")))
          ((string-match "\\.as[cphma]x\\.cs\\'" path)
           (find-file base))
          ((string-match "\\.\\(c\\(c\\|pp\\)?\\|mm?\\)\\'" path)
           (find-file (concat base ".h")))
          ((string-match "\\.h\\'" path)
           (dolist (ext '(".cc" ".cpp" ".c" ".mm" ".m"))
             (if (file-readable-p (concat base ext))
                 (find-file (concat base ext))))))))

(define-key mode-specific-map [tab] 'toggle-code-file)

(define-key mode-specific-map [space] 'just-one-space)
(define-key mode-specific-map [? ] 'just-one-space)
(define-key mode-specific-map [?1] 'just-one-space)

(define-key mode-specific-map [?b] 'ignore)
(define-key mode-specific-map [?c] 'compile)

(defun clone-region-set-mode (start end &optional mode)
  (interactive "r")
  (with-current-buffer (clone-indirect-buffer "*clone*" t)
    (narrow-to-region start end)
    (if mode
	(funcall mode)
      (lisp-mode))))

(define-key mode-specific-map [?C] 'clone-region-set-mode)

(defun delete-current-line (&optional arg)
  (interactive "p")
  (let ((here (point)))
    (beginning-of-line)
    (kill-line arg)
    (goto-char here)))

(define-key mode-specific-map [?d] 'delete-current-line)

(define-key mode-specific-map [?e ?a] 'byte-recompile-directory)

(defun do-eval-buffer ()
  (interactive)
  (call-interactively 'eval-buffer)
  (message "Buffer has been evaluated"))

(define-key mode-specific-map [?e ?b] 'do-eval-buffer)
(define-key mode-specific-map [?e ?c] 'cancel-debug-on-entry)
(define-key mode-specific-map [?e ?d] 'debug-on-entry)
(define-key mode-specific-map [?e ?f] 'emacs-lisp-byte-compile-and-load)
(define-key mode-specific-map [?e ?r] 'eval-region)

(defun scratch ()
  (interactive)
  (switch-to-buffer-other-window (get-buffer-create "*scratch*"))
  ;;(lisp-interaction-mode)
  (text-mode)
  (if current-prefix-arg
      (find-file "~/src/snippets.hs")
    (goto-char (point-min))
    (when (looking-at ";")
      (forward-line 4)
      (delete-region (point-min) (point)))
    (goto-char (point-max))))

(define-key mode-specific-map [?e ?s] 'scratch)
(define-key mode-specific-map [?e ?v] 'edit-variable)
(define-key mode-specific-map [?e ?e] 'toggle-debug-on-error)
(define-key mode-specific-map [?e ?E] 'elint-current-buffer)

(define-key mode-specific-map [?f] 'flush-lines)
(define-key mode-specific-map [?g] 'goto-line)
(define-key mode-specific-map [?h] 'ignore)

(define-key mode-specific-map [?i ?b] 'flyspell-buffer)
(define-key mode-specific-map [?i ?c] 'ispell-comments-and-strings)
(define-key mode-specific-map [?i ?d] 'ispell-change-dictionary)
(define-key mode-specific-map [?i ?f] 'flyspell-mode)
(define-key mode-specific-map [?i ?k] 'ispell-kill-ispell)
(define-key mode-specific-map [?i ?m] 'ispell-message)
(define-key mode-specific-map [?i ?r] 'ispell-region)

(define-key mode-specific-map [?j] 'ignore)
(define-key mode-specific-map [?k] 'keep-lines)

(defun my-ledger-start-entry (&optional arg)
  (interactive "p")
  (find-file-other-window "~/Dropbox/Accounts/ledger.dat")
  (goto-char (point-max))
  (skip-syntax-backward " ")
  (if (looking-at "\n\n")
      (goto-char (point-max))
    (delete-region (point) (point-max))
    (insert ?\n)
    (insert ?\n))
  (insert (format-time-string "%Y/%m/%d ")))

(define-key mode-specific-map [?l] 'my-ledger-start-entry)
(define-key mode-specific-map [?m] 'ignore)

(defcustom user-initials nil
  "*Initials of this user."
  :set #'(lambda (symbol value)
	   (if (fboundp 'font-lock-add-keywords)
	       (mapcar
		#'(lambda (mode)
		    (font-lock-add-keywords
		     mode (list (list (concat "\\<\\(" value " [^:\n]+\\):")
				      1 font-lock-warning-face t))))
		'(c-mode c++-mode emacs-lisp-mode lisp-mode
			 python-mode perl-mode java-mode groovy-mode)))
	   (set symbol value))
  :type 'string
  :group 'mail)

(defun insert-user-timestamp ()
  "Insert a quick timestamp using the value of `user-initials'."
  (interactive)
  (insert (format "%s (%s): " user-initials
		  (format-time-string "%Y-%m-%d" (current-time)))))

(define-key mode-specific-map [?n] 'insert-user-timestamp)
(define-key mode-specific-map [?o] 'customize-option)
(define-key mode-specific-map [?O] 'customize-group)
(define-key mode-specific-map [?p] 'ignore)
(define-key mode-specific-map [?q] 'fill-region)
(define-key mode-specific-map [?r] 'replace-regexp)
(define-key mode-specific-map [?s] 'replace-string)

(define-key mode-specific-map [?t ?%] 'tags-query-replace)
(define-key mode-specific-map [?t ?a] 'tags-apropos)
(define-key mode-specific-map [?t ?e] 'tags-search)
(define-key mode-specific-map [?t ?v] 'visit-tags-table)

(define-key mode-specific-map [?t ?a] 'tags-apropos)

(define-key mode-specific-map [?u] 'rename-uniquely)
(define-key mode-specific-map [?v] 'visit-url)

(defun view-clipboard ()
  (interactive)
  (delete-other-windows)
  (switch-to-buffer "*Clipboard*")
  (let ((inhibit-read-only t))
    (erase-buffer)
    (clipboard-yank)
    (goto-char (point-min))
    (html-mode)
    (view-mode)))

(define-key mode-specific-map [(shift ?v)] 'view-clipboard)

(define-key mode-specific-map [?w] 'wdired-change-to-wdired-mode)
(define-key mode-specific-map [?y] 'ignore)
(define-key mode-specific-map [?z] 'clean-buffer-list)

(define-key mode-specific-map [?\[] 'align-regexp)
(define-key mode-specific-map [?=]  'count-matches)
(define-key mode-specific-map [?\;] 'comment-or-uncomment-region)

;;;_ + footnote

(eval-after-load "footnote"
  '(define-key footnote-mode-map "#" 'redo-footnotes))

;;;_ + isearch-mode

(define-key isearch-mode-map [(control ?c)] 'isearch-toggle-case-fold)
(define-key isearch-mode-map [(control ?t)] 'isearch-toggle-regexp)
(define-key isearch-mode-map [(control ?^)] 'isearch-edit-string)
(define-key isearch-mode-map [(control ?i)] 'isearch-complete)

;;;_ + mail-mode

(eval-after-load "sendmail"
  '(define-key mail-mode-map [(control ?i)] 'mail-complete))

;;;_* startup

(load ".org")
(load ".gnus")

(add-hook 'after-init-hook 'server-start)

(defun large-font ()
  (interactive)
  (set-frame-font "-apple-Courier-medium-normal-normal-*-16-*-*-*-m-0-iso10646-1"))

;; .emacs.el ends here
