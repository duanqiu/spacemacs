(with-eval-after-load 'org

(setq org-agenda-files '("~/Emacs_files/Org"))

(setq org-default-notes-file "~/Emacs_files/Org/inbox.org")

(setq org-capture-templates

  `(("t" "Task" table-line (file ,"~/Emacs_files/Org/inbox.org")
   "| %T |%^T| --- |%^{事件}|%^{描述}| *TODO* |")
  ("p" "Apperception" entry (file+headline ,"~/Emacs_files/Org/note.org" "Apperception")
  "**  %^{heading} - %U \n  *%^{前言}* \n %?")
  ("d" "daily program" entry (file+datetree ,"~/Emacs_files/Org/task.org" )
   "**  %?\n ") 
  ("e" "Extract" entry (file+headline ,"~/Emacs_files/Org/note.org" "extract")
   "** %^{heading} - %U \n  %x\n")
  ("u" "Understanding of events" entry (file+headline ,"~/Emacs_files/Org/note.org" "Understanding of events")
   "**  %U -  %^{heading}\n  *%^{前言}* \n %?")
  ("a" "makeshift arrangement" entry (file+headline ,"~/Emacs_files/Org/inbox.org" "makeshift arrangement")
   "** TODO %?\n") 
  )
)
)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "<f11>") 'org-capture)

;;orgmode 断行
(defun my-org-mode ()
  (setq truncate-lines nil)
  )

(add-hook 'org-mode-hook 'my-org-mode)

;; refer http://doc.norang.ca/org-mode.html
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))


;; 下面是设置截图功能

(defun my-screenshot ()
  "Take a screenshot into a unique-named file in the current buffer file
 directory and insert a link to this file."
  (interactive)
  (setq filename
        (concat (make-temp-name
                 (concat (file-name-directory (buffer-file-name)) "images/" ) ) ".png"))
  (if (file-accessible-directory-p (concat (file-name-directory
 (buffer-file-name)) "images/"))
  nil
  (make-directory "images"))
  (call-process-shell-command "scrot" nil nil nil "-s" (concat
                              "\"" filename "\"" ))
(insert (concat "[[" filename "]]"))
(org-display-inline-images) 
)


(defun my-LaTeX-mode()
    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
    (setq TeX-command-default "XeLaTeX") 
    (setq TeX-save-query  nil )
    (setq TeX-show-compilation t)
    (setq TeX-view-program-list
        '(("Sumatra PDF" ("\"c:/Program Files/SumatraPDF/SumatraPDF.exe\" -reuse-instance"
                          (mode-io-correlate "-forward-search %b %n ") "%o"
                          )))
        )

     ;; (cdlatex-mode t) ;; 好像不用这一行即可启用cdlatex-mode
    )
  (add-hook 'LaTeX-mode-hook 'my-LaTeX-mode)
  
 (dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family "汉仪瘦金书简" :size 22)))
