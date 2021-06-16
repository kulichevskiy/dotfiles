;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq global-evil-surround-mode 1)

(setq user-full-name "Alexey Kulichevskiy"
      user-mail-address "alexey.kulichevskiy@gmail.com"
      doom-theme 'doom-one
      display-line-numbers-type t)

(setq org-directory "~/Dropbox/org/"
      org-agenda-files (list "~/Dropbox/org/" "~/Dropbox/org/journal/")
      org-todo-keywords '((type "TODO" "STARTED" "WAITING" "|" "DONE" "CANCELED"))
      org-library (concat org-directory "library.bib")
      org-ellipsis " ▼ ")

(use-package org-roam
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory org-directory)
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n j" . org-roam-jump-to-index)
               ("C-c n b" . org-roam-switch-to-buffer)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))))

(global-set-key (kbd "C-;") 'org-roam-insert)
(global-set-key (kbd "C-ж") 'org-roam-insert)

(use-package org-journal
  :ensure t
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir (concat org-directory "journal/")
        org-journal-file-type 'daily
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%A, %d %B %Y")
        org-journal-time-format "%H:%M")

(map! :leader
      (:prefix-map ("a" . "applications")

       (:prefix ("j" . "journal")
        :desc "New journal entry" "j" #'org-journal-new-entry
        :desc "Search journal entry" "s" #'org-journal-search)

       (:prefix ("r" . "roam")
        :desc "Find File" "f" #'org-roam-find-file
        :desc "Show Roam Outline" "l" #'org-roam)))

(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)) ; optional: if Org Ref is not loaded anywhere else, load it here

(setq bibtex-completion-notes-path org-directory)
(setq bibtex-completion-bibliography org-library)

(setq projectile-project-search-path '("~/Code/"))

(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            web-mode
            html-mode
            latex-mode))

(set-formatter! 'html-tidy
  '("tidy" "-q" "-indent"
    "--tidy-mark" "no"
    "--drop-empty-elements" "no"
    "--show-body-only" "auto"
    ("--indent-spaces" "%d" tab-width)
    ("--indent-with-tabs" "%s" (if indent-tabs-mode "yes" "no"))
    ("-xml" (memq major-mode '(nxml-mode xml-mode))))
  :ok-statuses '(0 1))

(global-visual-line-mode t)

