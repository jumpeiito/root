(provide 'mcomplete-imenu)

(defcustom imenu-modes
  '(emacs-lisp-mode c-mode c++-mode makefile-mode)
  "List of major modes for which Imenu mode should be used."
  :group 'imenu
  :type '(choice (const :tag "All modes" t)
                 (repeat (symbol :tag "Major mode"))))
(defun my-imenu-ff-hook ()
  "File find hook for Imenu mode."
  (if (member major-mode imenu-modes)
      (imenu-add-to-menubar "imenu")))
(add-hook 'find-file-hooks 'my-imenu-ff-hook t)
     
;; imenu + mocomplete
(defadvice imenu--completion-buffer
  (around mcomplete activate preactivate)
  "Support for mcomplete-mode."
  (require 'mcomplete)
  (let ((imenu-use-popup-menu 'never) ;; imenu-always-use-completion-buffer-p is obsolete
        (mode mcomplete-mode)
        ;; the order of completion methods
        (mcomplete-default-method-set '(mcomplete-substr-method
                                        mcomplete-prefix-method))
        ;; when to display completion candidates in the minibuffer
        (mcomplete-default-exhibit-start-chars 0)
        (completion-ignore-case t))
    ;; display *Completions* buffer on entering the minibuffer
    (setq unread-command-events
          (cons (funcall (if (fboundp 'character-to-event)
                             'character-to-event
                           'identity)
                         ?\?)
                unread-command-events))
    (turn-on-mcomplete-mode)
    (unwind-protect
        ad-do-it
      (unless mode
        (turn-off-mcomplete-mode)))))
