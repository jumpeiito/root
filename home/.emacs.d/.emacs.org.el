(require 'org-install)
;; ;; (require 'ob)
;; ;; (require 'ob-scheme)
(setq org-babel-scheme-cmd "gosh")
(setq browse-url-browser-function 'browse-url-firefox)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-ca" 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(org-remember-insinuate)
(setq org-hide-leading-stars t)
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %T" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %T" nil "Inbox")
        ("News" ?n "** %?\n   %i\n   %a\n   %T" "~/memo/news.org" "News")
        ))

(defun org-feed-parse-rdf-feed (buffer)
  "Parse BUFFER for RDF feed entries.
Returns a list of entries, with each entry a property list,
containing the properties `:guid' and `:item-full-text'."
  (let (entries beg end item guid entry)
    (with-current-buffer buffer
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "<item[> ]" nil t)
	(setq beg (point)
	      end (and (re-search-forward "</item>" nil t)
		       (match-beginning 0)))
	(setq item (buffer-substring beg end)
	      guid (if (string-match "<link\\>.*?>\\(.*?\\)</link>" item)
		       (org-match-string-no-properties 1 item)))
	(setq entry (list :guid guid :item-full-text item))
	(push entry entries)
	(widen)
	(goto-char end))
      (nreverse entries))))

(setq org-feed-retrieve-method 'wget)
;(setq org-feed-retrieve-method 'curl)

(setq org-feed-default-template "\n* %h\n  - %U\n  - %a  - %description")

(defvar org-feed-alist nil)
(add-to-list 'org-feed-alist
  '("hatena" "http://feeds.feedburner.com/hatena/b/hotentry"
    "~/memo/rss.org" "はてな"
    :parse-feed org-feed-parse-rdf-feed))
(add-to-list 'org-feed-alist
  '("asahi" "http://www3.asahi.com/rss/international.rdf"
    "~/memo/rss.org" "朝日新聞・国際"
    :parse-feed org-feed-parse-rdf-feed))
(add-to-list 'org-feed-alist
  '("asahi" "http://www3.asahi.com/rss/business.rdf"
    "~/memo/rss.org" "朝日新聞・ビジネス"
    :parse-feed org-feed-parse-rdf-feed))
(add-to-list 'org-feed-alist
  '("tamura70" "http://d.hatena.ne.jp/tamura70/rss"
    "~/memo/rss.org" "屯遁"
    :parse-feed org-feed-parse-rdf-feed))
