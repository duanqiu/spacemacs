(with-eval-after-load 'org

(setq org-agenda-files '("~/Emacs_files/Org"))

(setq org-default-notes-file "~/Emacs_files/Org/inbox.org")

(setq org-capture-templates

  `(("t" "Task" entry (file+headline ,"~/Emacs_files/Org/inbox.org" "任务记录")
   "** TODO %?\n  %a")
  ("b" "Blog" entry (file+headline ,"~/Emacs_files/Org/Blog.org" "感想")
   "**  %?\n  %a")
  ("d" "daily program" entry (file+datetree ,"~/Emacs_files/Org/task.org" )
   "**  %?\n  %a")
  ("c" "Copy" entry (file+headline ,"~/Emacs_files/Org/Blog.org" "摘抄")
   "**  %?\n  %a")
  ("s" "Study" entry (file+headline ,"~/Emacs_files/Org/Blog.org" "对某件事的理解")
   "** TODO %?\n  %a")
  ("n" "Note" entry (file+headline ,"~/Emacs_files/Org/inbox.org" "临时安排事项")
   "** TODO %?\n  %a")))
)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "<f12>") 'org-capture)

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




