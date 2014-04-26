;;; color-theme-library.el --- The real color theme functions

;; Splitted to ct-**themename**.el

;; Copyright (C) 2005, 2006  Xavier Maillard <zedek@gnu.org>
;; Copyright (C) 2005, 2006  Brian Palmer <bpalmer@gmail.com>

;; Version: 0.0.9
;; Keywords: faces
;; Author: Brian Palmer, Xavier Maillard
;; Maintainer: Xavier Maillard <zedek@gnu.org>
;; URL: http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme

;; This file is not (YET) part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;; Code:
(eval-when-compile
  (require 'color-theme))
(autoload 'color-theme-gnome "ct-gnome""theme for color-theme." t)
(autoload 'color-theme-blue-gnus "ct-blue-gnus""theme for color-theme." t)
(autoload 'color-theme-dark-gnus "ct-dark-gnus""theme for color-theme." t)
(autoload 'color-theme-blue-eshell "ct-blue-eshell""theme for color-theme." t)
(autoload 'color-theme-salmon-font-lock "ct-salmon-font-lock""theme for color-theme." t)
(autoload 'color-theme-dark-font-lock "ct-dark-font-lock""theme for color-theme." t)
(autoload 'color-theme-dark-info "ct-dark-info""theme for color-theme." t)
(autoload 'color-theme-gnome2 "ct-gnome2""theme for color-theme." t)
(autoload 'color-theme-simple-1 "ct-simple-1""theme for color-theme." t)
(autoload 'color-theme-jonadabian "ct-jonadabian""theme for color-theme." t)
(autoload 'color-theme-ryerson "ct-ryerson""theme for color-theme." t)
(autoload 'color-theme-wheat "ct-wheat""theme for color-theme." t)
(autoload 'color-theme-standard "ct-standard""theme for color-theme." t)
(autoload 'color-theme-fischmeister "ct-fischmeister""theme for color-theme." t)
(autoload 'color-theme-sitaramv-solaris "ct-sitaramv-solaris""theme for color-theme." t)
(autoload 'color-theme-sitaramv-nt "ct-sitaramv-nt""theme for color-theme." t)
(autoload 'color-theme-billw "ct-billw""theme for color-theme." t)
(autoload 'color-theme-retro-green "ct-retro-green""theme for color-theme." t)
(autoload 'color-theme-retro-orange "ct-retro-orange""theme for color-theme." t)
(autoload 'color-theme-subtle-hacker "ct-subtle-hacker""theme for color-theme." t)
(autoload 'color-theme-pok-wog "ct-pok-wog""theme for color-theme." t)
(autoload 'color-theme-pok-wob "ct-pok-wob""theme for color-theme." t)
(autoload 'color-theme-blue-sea "ct-blue-sea""theme for color-theme." t)
(autoload 'color-theme-rotor "ct-rotor""theme for color-theme." t)
(autoload 'color-theme-pierson "ct-pierson""theme for color-theme." t)
(autoload 'color-theme-xemacs "ct-xemacs""theme for color-theme." t)
(autoload 'color-theme-jsc-light "ct-jsc-light""theme for color-theme." t)
(autoload 'color-theme-jsc-dark "ct-jsc-dark""theme for color-theme." t)
(autoload 'color-theme-greiner "ct-greiner""theme for color-theme." t)
(autoload 'color-theme-jb-simple "ct-jb-simple""theme for color-theme." t)
(autoload 'color-theme-beige-diff "ct-beige-diff""theme for color-theme." t)
(autoload 'color-theme-standard-ediff "ct-standard-ediff""theme for color-theme." t)
(autoload 'color-theme-beige-eshell "ct-beige-eshell""theme for color-theme." t)
(autoload 'color-theme-goldenrod "ct-goldenrod""theme for color-theme." t)
(autoload 'color-theme-ramangalahy "ct-ramangalahy""theme for color-theme." t)
(autoload 'color-theme-raspopovic "ct-raspopovic""theme for color-theme." t)
(autoload 'color-theme-taylor "ct-taylor""theme for color-theme." t)
(autoload 'color-theme-marquardt "ct-marquardt""theme for color-theme." t)
(autoload 'color-theme-parus "ct-parus""theme for color-theme." t)
(autoload 'color-theme-high-contrast "ct-high-contrast""theme for color-theme." t)
(autoload 'color-theme-infodoc "ct-infodoc""theme for color-theme." t)
(autoload 'color-theme-classic "ct-classic""theme for color-theme." t)
(autoload 'color-theme-scintilla "ct-scintilla""theme for color-theme." t)
(autoload 'color-theme-gtk-ide "ct-gtk-ide""theme for color-theme." t)
(autoload 'color-theme-midnight "ct-midnight""theme for color-theme." t)
(autoload 'color-theme-jedit-grey "ct-jedit-grey""theme for color-theme." t)
(autoload 'color-theme-snow "ct-snow""theme for color-theme." t)
(autoload 'color-theme-montz "ct-montz""theme for color-theme." t)
(autoload 'color-theme-aalto-light "ct-aalto-light""theme for color-theme." t)
(autoload 'color-theme-aalto-dark "ct-aalto-dark""theme for color-theme." t)
(autoload 'color-theme-blippblopp "ct-blippblopp""theme for color-theme." t)
(autoload 'color-theme-hober "ct-hober""theme for color-theme." t)
(autoload 'color-theme-bharadwaj "ct-bharadwaj""theme for color-theme." t)
(autoload 'color-theme-oswald "ct-oswald""theme for color-theme." t)
(autoload 'color-theme-salmon-diff "ct-salmon-diff""theme for color-theme." t)
(autoload 'color-theme-robin-hood "ct-robin-hood""theme for color-theme." t)
(autoload 'color-theme-snowish "ct-snowish""theme for color-theme." t)
(autoload 'color-theme-dark-laptop "ct-dark-laptop""theme for color-theme." t)
(autoload 'color-theme-taming-mr-arneson "ct-taming-mr-arneson""theme for color-theme." t)
(autoload 'color-theme-digital-ofs1 "ct-digital-ofs1""theme for color-theme." t)
(autoload 'color-theme-mistyday "ct-mistyday""theme for color-theme." t)
(autoload 'color-theme-marine "ct-marine""theme for color-theme." t)
(autoload 'color-theme-blue-erc "ct-blue-erc""theme for color-theme." t)
(autoload 'color-theme-dark-erc "ct-dark-erc""theme for color-theme." t)
(autoload 'color-theme-subtle-blue "ct-subtle-blue""theme for color-theme." t)
(autoload 'color-theme-dark-blue "ct-dark-blue""theme for color-theme." t)
(autoload 'color-theme-jonadabian-slate "ct-jonadabian-slate""theme for color-theme." t)
(autoload 'color-theme-gray1 "ct-gray1""theme for color-theme." t)
(autoload 'color-theme-word-perfect "ct-word-perfect""theme for color-theme." t)

;; In order to produce this, follow these steps:
;;
;; 0. Make sure .Xresources and .Xdefaults don't have any Emacs related
;;    entries.
;;
;; 1. cd into the Emacs lisp directory and run the following command:
;;    ( for d in `find -type d`; \
;;      do grep --files-with-matches 'defface[		]' $d/*.el; \
;;      done ) | sort | uniq
;;    Put the result in a lisp block, using load-library calls.
;;
;;    Repeat this for any directories on your load path which you want to
;;    include in the standard.  This might include W3, eshell, etc.
;;
;;    Add some of the libraries that don't use defface:
;;
;; 2. Start emacs using the --no-init-file and --no-site-file command line
;;    arguments.  Evaluate the lisp block you prepared.
;; 3. Load color-theme and run color-theme-print.  Save the output and use it
;;    to define color-theme-standard.
;;
;; (progn
;; (load-library "add-log")
;; (load-library "calendar")
;; (load-library "comint")
;; (load-library "cus-edit")
;; (load-library "cus-face")
;; (load-library "custom")
;; (load-library "diff-mode")
;; (load-library "ediff-init")
;; (load-library "re-builder")
;; (load-library "viper-init")
;; (load-library "enriched")
;; (load-library "em-ls")
;; (load-library "em-prompt")
;; (load-library "esh-test")
;; (load-library "faces")
;; (load-library "font-lock")
;; (load-library "generic-x")
;; (load-library "gnus-art")
;; (load-library "gnus-cite")
;; (load-library "gnus")
;; (load-library "message")
;; (load-library "hilit-chg")
;; (load-library "hi-lock")
;; (load-library "info")
;; (load-library "isearch")
;; (load-library "log-view")
;; (load-library "paren")
;; (load-library "pcvs-info")
;; (load-library "antlr-mode")
;; (load-library "cperl-mode")
;; (load-library "ebrowse")
;; (load-library "idlwave")
;; (load-library "idlw-shell")
;; (load-library "make-mode")
;; (load-library "sh-script")
;; (load-library "vhdl-mode")
;; (load-library "smerge-mode")
;; (load-library "speedbar")
;; (load-library "strokes")
;; (load-library "artist")
;; (load-library "flyspell")
;; (load-library "texinfo")
;; (load-library "tex-mode")
;; (load-library "tooltip")
;; (load-library "vcursor")
;; (load-library "wid-edit")
;; (load-library "woman")
;; (load-library "term")
;; (load-library "man")
;; (load-file "/home/alex/elisp/color-theme.el")
;; (color-theme-print))
;;
;; 4. Make the color theme usable on Xemacs (add more faces, resolve
;;    :inherit attributes)
;;
(autoload 'color-theme-emacs-21 "ct-emacs-21""theme for color-theme." t)
(autoload 'color-theme-jsc-light2 "ct-jsc-light2""theme for color-theme." t)
(autoload 'color-theme-ld-dark "ct-ld-dark""theme for color-theme." t)
(autoload 'color-theme-deep-blue "ct-deep-blue""theme for color-theme." t)
(autoload 'color-theme-kingsajz "ct-kingsajz""theme for color-theme." t)
(autoload 'color-theme-comidia "ct-comidia""theme for color-theme." t)
(autoload 'color-theme-katester "ct-katester""theme for color-theme." t)
(autoload 'color-theme-arjen "ct-arjen""theme for color-theme." t)
(autoload 'color-theme-tty-dark "ct-tty-dark""theme for color-theme." t)
(autoload 'color-theme-aliceblue "ct-aliceblue""theme for color-theme." t)
(autoload 'color-theme-black-on-gray "ct-black-on-gray""theme for color-theme." t)
(autoload 'color-theme-dark-blue2 "ct-dark-blue2""theme for color-theme." t)
(autoload 'color-theme-blue-mood "ct-blue-mood""theme for color-theme." t)
(autoload 'color-theme-euphoria "ct-euphoria""theme for color-theme." t)
(autoload 'color-theme-resolve "ct-resolve""theme for color-theme." t)
(autoload 'color-theme-xp "ct-xp""theme for color-theme." t)
(autoload 'color-theme-gray30 "ct-gray30""theme for color-theme." t)
(autoload 'color-theme-dark-green "ct-dark-green""theme for color-theme." t)
(autoload 'color-theme-whateveryouwant "ct-whateveryouwant""theme for color-theme." t)
(autoload 'color-theme-bharadwaj-slate "ct-bharadwaj-slate""theme for color-theme." t)
(autoload 'color-theme-lethe "ct-lethe""theme for color-theme." t)
(autoload 'color-theme-shaman "ct-shaman""theme for color-theme." t)
(autoload 'color-theme-emacs-nw "ct-emacs-nw""theme for color-theme." t)
(autoload 'color-theme-late-night "ct-late-night""theme for color-theme." t)
(autoload 'color-theme-clarity "ct-clarity""theme for color-theme." t)
(autoload 'color-theme-andreas "ct-andreas""theme for color-theme." t)
(autoload 'color-theme-charcoal-black "ct-charcoal-black""theme for color-theme." t)
(autoload 'color-theme-vim-colors "ct-vim-colors""theme for color-theme." t)
(autoload 'color-theme-calm-forest "ct-calm-forest""theme for color-theme." t)
(autoload 'color-theme-lawrence "ct-lawrence""theme for color-theme." t)
(autoload 'color-theme-matrix "ct-matrix""theme for color-theme." t)
(autoload 'color-theme-feng-shui "ct-feng-shui""theme for color-theme." t)

(autoload 'color-theme-renegade "ct-renegade""theme for color-theme." t)
(autoload 'color-theme-ubuntu2 "color-theme-ubuntu2""theme for color-theme." t)
(autoload 'color-theme-twilight "color-theme-twilight""theme for color-theme." t)
(autoload 'color-theme-railcast "color-theme-railcast""theme for color-theme." t)
;;; color-theme-library.el ends here
