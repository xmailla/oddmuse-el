;;; anything-oddmuse.el --- Anything configuration for oddmuse.el

;; Copyright (C) 2009  Xavier Maillard

;; Author: Xavier Maillard <xma@gnu.org>
;; Keywords: extensions, hypermedia

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'anything-config)
(cdr (assoc "EmacsWiki" oddmuse-wikis))
(defvar anything-c-source-emacswiki-pages
  '((name . "EmacsWiki")
    (init . (lambda () (when (assoc "EmacsWiki" oddmuse-wikis) (oddmuse-make-completion-table "EmacsWiki"))))
    (candidates
     . (lambda () (gethash "EmacsWiki" oddmuse-pages-hash)))
    (action
     ("Visit page" . (lambda (candidate)
                                (oddmuse-edit "EmacsWiki" candidate)))
     ("Delete page" . (lambda (candidate)
                      (oddmuse-delete candidate))))

     )

    (persistent-action
     . (lambda (candidate)
         (oddmuse-edit "EmacsWiki" candidate)))))

(defvar anything-c-source-yaoddmuse-emacswiki-edit-or-view
  '((name . "Yaoddmuse Edit or View (EmacsWiki)")
    (candidates . (lambda ()
                    (yaoddmuse-update-pagename t)
                    (gethash "EmacsWiki" yaoddmuse-pages-hash)))
    (action . (("Edit page" . (lambda (candidate)
                                (yaoddmuse-edit "EmacsWiki" candidate)))
               ("Browse page" . (lambda (candidate)
                                  (yaoddmuse-browse-page "EmacsWiki" candidate)))
               ("Browse page other window" . (lambda (candidate)
                                               (if (one-window-p)
                                                   (split-window-vertically))
                                               (yaoddmuse-browse-page "EmacsWiki" candidate)))
               ("Create page" . (lambda (candidate)
                                  (yaoddmuse-edit "EmacsWiki" anything-input)))
               ("Update page name" . (lambda (candidate)
                                       (yaoddmuse-update-pagename)))))))

(add-to-list 'anything-sources 'anything-c-source-emacswiki-pages)
(provide 'anything-oddmuse)
;;; anything-oddmuse.el ends here
