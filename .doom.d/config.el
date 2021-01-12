;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq global-evil-surround-mode 1)

(setq user-full-name "Alexey Kulichevskiy"
      user-mail-address "alexey.kulichevskiy@gmail.com"
      doom-theme 'doom-one
      display-line-numbers-type t)

(setq org-directory "~/org/"
      orb-library (concat org-directory "library.bib")
      org-ellipsis " ▼ ")

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

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


(use-package org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq org-roam-bibtex-preformat-keywords
    '("=key=" "title" "author" "year" "month" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point) ""
           :file-name "${slug}"
           :head "#+title: ${title}
#+roam_key: ${ref}

:properties:
  :custom_id: ${ref}
  :author: ${author}
  :year: ${year}
  :month: ${month}
:end:\n\n"
           :unnarrowed t))))

(setq
 bibtex-completion-notes-path org-directory
 bibtex-completion-bibliography orb-library
 bibtex-completion-pdf-field "file"
)

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   )
  )

(use-package org-ref
    :config
    (setq
         org-ref-completion-library 'org-ref-ivy-cite
         org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
         org-ref-default-bibliography (list orb-library)
         org-ref-bibliography-notes "~/org/bibnotes.org"
         org-ref-note-title-format "* TODO %y - %t\n :properties:\n  :custom_id: %k\n  :noter_document: %f\n :roam_key: cite:%k\n  :author: %9a\n  :journal: %j\n  :year: %y\n  :volume: %v\n  :pages: %p\n  :doi: %D\n  :url: %U\n :end:\n\n"
         org-ref-notes-directory "/home/haozeke/Git/Gitlab/Mine/Notes/"
         org-ref-notes-function 'orb-edit-notes
         ))

(setq org-roam-server-host "127.0.0.1"
          org-roam-server-port 8080
          org-roam-server-export-inline-images t
          org-roam-server-authenticate nil
          org-roam-server-network-poll t
          org-roam-server-network-arrows nil
          org-roam-server-network-label-truncate t
          org-roam-server-network-label-truncate-length 60
          org-roam-server-network-label-wrap-length 20)

(global-set-key (kbd "C-;") 'org-roam-insert)
(global-set-key (kbd "C-ж") 'org-roam-insert)

(setq org-roam-capture-templates
        '(
          ("d" "default" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "%(format-time-string \"%Y%m%d%H%M%SZ-${slug}\" (current-time) t)"
           :head "#+title: ${title}\n#+startup: hidestars\n#+startup: indent\n#+roam_tags: \n:properties:\n:created_at: %U\n:end:\n\n* Source\n* Related\n* Content\n")
          ("p" "permanent note" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "%(format-time-string \"%Y%m%d%H%M%SZ-${slug}\" (current-time) t)"
           :head "#+title: ${title}\n#+startup: hidestars\n#+startup: indent\n#+roam_tags: per\n:properties:\n:created_at: %U\n:end:\n\n* Source\n* Related\n* Content\n")

          ("l" "literature note" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "%(format-time-string \"%Y%m%d%H%M%SZ-${slug}\" (current-time) t)"
           :head "#+title: ${title}\n#+startup: hidestars\n#+startup: indent\n#+roam_tags: lit\n:properties:\n:created_at: %U\n:end:\n\n* References\n** Author\n** Summary\n* Related\n* Notes\n\n")
          ))


(setq org-image-actual-width nil
        org-image-actual-width '(500))

(use-package org-journal
  :ensure t
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir (concat org-directory "journal/")
        org-journal-file-type 'weekly
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

(defun org-journal-file-header-func (time)
  "Custom function to create journal header."
  (concat
    (pcase org-journal-file-type
      (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
      (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
      (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
      (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))

(setq org-journal-file-header 'org-journal-file-header-func)

;; set global keys
(define-key key-translation-map (kbd "C-х") [escape])
(define-key key-translation-map (kbd "C-п") (kbd "C-g"))
(define-key key-translation-map (kbd "M-й") (kbd "M-q"))
(define-key key-translation-map (kbd "M-ч") (kbd "M-x"))

;; normal state map
(define-key evil-normal-state-map "ф" 'evil-append)
(define-key evil-normal-state-map "Ф" 'evil-append-line)
(define-key evil-normal-state-map "с" 'evil-change)
(define-key evil-normal-state-map "С" 'evil-change-line)
(define-key evil-normal-state-map "в" 'evil-delete)
(define-key evil-normal-state-map "В" 'evil-delete-line)
(define-key evil-normal-state-map "ш" 'evil-insert)
(define-key evil-normal-state-map "Ш" 'evil-insert-line)
(define-key evil-normal-state-map "О" 'evil-join)
(define-key evil-normal-state-map "ь" 'evil-set-marker)
(define-key evil-normal-state-map "щ" 'evil-open-below)
(define-key evil-normal-state-map "Щ" 'evil-open-above)
(define-key evil-normal-state-map "з" 'evil-paste-after)
(define-key evil-normal-state-map "З" 'evil-paste-before)
(define-key evil-normal-state-map "й" 'evil-record-macro)
(define-key evil-normal-state-map "к" 'evil-replace)
(define-key evil-normal-state-map "К" 'evil-replace-state)
(define-key evil-normal-state-map "ы" 'evil-substitute)
(define-key evil-normal-state-map "Ы" 'evil-change-whole-line)
(define-key evil-normal-state-map "ч" 'evil-delete-char)
(define-key evil-normal-state-map "Ч" 'evil-delete-backward-char)
(define-key evil-normal-state-map "н" 'evil-yank)
(define-key evil-normal-state-map "Н" 'evil-yank-line)
(define-key evil-normal-state-map "Б" 'evil-shift-left)
(define-key evil-normal-state-map "Ю" 'evil-shift-right)
(define-key evil-normal-state-map "Ж" 'evil-ex)

  ;; Motion state map
(define-key evil-motion-state-map "и" 'evil-backward-word-begin)
(define-key evil-motion-state-map "И" 'evil-backward-WORD-begin)
(define-key evil-motion-state-map "у" 'evil-forward-word-end)
(define-key evil-motion-state-map "У" 'evil-forward-WORD-end)
(define-key evil-motion-state-map "а" 'evil-find-char)
(define-key evil-motion-state-map "А" 'evil-find-char-backward)
(define-key evil-motion-state-map "П" 'evil-goto-line)
(define-key evil-motion-state-map "р" 'evil-backward-char)
(define-key evil-motion-state-map "Р" 'evil-window-top)

(define-key evil-motion-state-map "о" 'evil-next-visual-line)
(define-key evil-motion-state-map "л" 'evil-previous-visual-line)
(define-key evil-motion-state-map "0" 'evil-beginning-of-line)
(define-key evil-motion-state-map "п;" 'evil-end-of-line) ;; to not clash with regular ;

(define-key evil-motion-state-map "д" 'evil-forward-char)
(define-key evil-motion-state-map "Л" 'evil-lookup)
(define-key evil-motion-state-map "Д" 'evil-window-bottom)
(define-key evil-motion-state-map "Ь" 'evil-window-middle)
(define-key evil-motion-state-map "т" 'evil-search-next)
(define-key evil-motion-state-map "Т" 'evil-search-previous)
(define-key evil-motion-state-map "е" 'evil-find-char-to)
(define-key evil-motion-state-map "Е" 'evil-find-char-to-backward)
(define-key evil-motion-state-map "ц" 'evil-forward-word-begin)
(define-key evil-motion-state-map "Ц" 'evil-forward-WORD-begin)

(define-key evil-motion-state-map "Х" 'evil-backward-paragraph)
(define-key evil-motion-state-map "Ъ" 'evil-forward-paragraph)
(define-key evil-motion-state-map (kbd "C-ц") 'evil-window-map)
(define-key evil-motion-state-map (kbd "C-и") 'evil-scroll-page-up)
(define-key evil-motion-state-map (kbd "C-в") 'evil-scroll-down)
(define-key evil-motion-state-map (kbd "C-г") 'evil-scroll-up)
(define-key evil-motion-state-map (kbd "C-у") 'evil-scroll-line-down)
(define-key evil-motion-state-map (kbd "C-а") 'evil-scroll-page-down)
(define-key evil-motion-state-map (kbd "C-щ") 'evil-jump-backward)
(define-key evil-motion-state-map (kbd "C-н") 'evil-scroll-line-up)
(define-key evil-motion-state-map "м" 'evil-visual-char)
(define-key evil-motion-state-map "М" 'evil-visual-line)
(define-key evil-motion-state-map (kbd "C-м") 'evil-visual-block)

;; Text objects (outer)
(define-key evil-outer-text-objects-map "ц" 'evil-a-word)
(define-key evil-outer-text-objects-map "Ц" 'evil-a-WORD)
(define-key evil-outer-text-objects-map "ы" 'evil-a-sentence)
(define-key evil-outer-text-objects-map "з" 'evil-a-paragraph)
(define-key evil-outer-text-objects-map "и" 'evil-a-paren)
(define-key evil-outer-text-objects-map "И" 'evil-a-curly)
(define-key evil-outer-text-objects-map "Б" 'evil-an-angle)
(define-key evil-outer-text-objects-map "Ю" 'evil-an-angle)
(define-key evil-outer-text-objects-map "е" 'evil-a-tag)

;; Text object (inner)
(define-key evil-inner-text-objects-map "ц" 'evil-inner-word)
(define-key evil-inner-text-objects-map "Ц" 'evil-inner-WORD)
(define-key evil-inner-text-objects-map "ы" 'evil-inner-sentence)
(define-key evil-inner-text-objects-map "з" 'evil-inner-paragraph)
(define-key evil-inner-text-objects-map "и" 'evil-inner-paren)
(define-key evil-inner-text-objects-map "И" 'evil-inner-curly)
(define-key evil-inner-text-objects-map "Б" 'evil-inner-angle)
(define-key evil-inner-text-objects-map "Ю" 'evil-inner-angle)
(define-key evil-inner-text-objects-map "е" 'evil-inner-tag)

;; Visual state map
(define-key evil-visual-state-map "Ф" 'evil-append)
(define-key evil-visual-state-map "Ш" 'evil-insert)
(define-key evil-visual-state-map "щ" 'exchange-point-and-mark)
(define-key evil-visual-state-map "Щ" 'evil-visual-exchange-corners)
(define-key evil-visual-state-map "К" 'evil-change)
(define-key evil-visual-state-map "г" 'evil-downcase)
(define-key evil-visual-state-map "Г" 'evil-upcase)
(define-key evil-visual-state-map "ф" evil-outer-text-objects-map)
(define-key evil-visual-state-map "ш" evil-inner-text-objects-map)

;; Operator pending state map
(define-key evil-operator-state-map "ф" evil-outer-text-objects-map)
(define-key evil-operator-state-map "ш" evil-inner-text-objects-map)

(evil-ex-define-cmd "е" "copy")
(evil-ex-define-cmd "Б" 'evil-shift-left)
(evil-ex-define-cmd "Ю" 'evil-shift-right)

;; Undo
(define-key evil-normal-state-map "г" 'undo)
(global-set-key (kbd "C-к") 'redo)

(map! :leader
  "ц" (lookup-key doom-leader-map "w"))
