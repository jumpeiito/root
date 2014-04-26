;;; -*- Mode: Emacs-Lisp ; Coding: iso-2022-jp-dos -*-
;;
;; uenox-dired.el : Dired モードを拡張する Emacs Lisp スクリプト
;; Copyright (C) 2000 UENO Tetsuyuki
;;
;; 本プログラムはフリー・ソフトウェアです。
;; 　あなたは、Free Software Foundationが公表したGNU 一般公有使用許諾の
;;「バージョン２」或いはそれ以降の各バージョンの中からいずれかを選択し、
;; そのバージョンが定める条項に従って本プログラムを再頒布または変更する
;; ことができます。
;; 　本プログラムは有用とは思いますが、頒布にあたっては、市場性及び特定
;; 目的適合性についての暗黙の保証を含めて、いかなる保証も行ないません。
;; 詳細についてはGNU 一般公有使用許諾書をお読みください。
;; 　あなたは、本プログラムと一緒にGNU一般公有使用許諾の写しを受け取って
;; いるはずです。そうでない場合は、
;;   Free Software Foundation, Inc.,
;;   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA 
;; へ手紙を書いてください。
;;
;; 著作者: 上野 哲幸 "UENO Tetsuyuki" <uenox@black.livedoor.com>
;; 版情報: 1.00
;; 作成日時：2000/10/21
;; 配布場所: http://uenox.infoseek.livedoor.net/elisp/uenox-dired.el
;;
;;
;;【導入】
;;  上記の配布場所からファイルをダウンロードして、ホームディレクトリ("~")
;;  に格納してください。
;;
;;【設定】
;;  初期化ファイル .emacs に以下の行を書き加えてください。
;;    (setq load-path (cons "~" load-path))
;;    (load "uenox-dired")
;;
;;【説明】
;;  Dired に以下の3つの機能が追加されます。（キーマップはこのファイルの
;;  最後の方を書き換えることで変更できます。）
;;   * C-j 
;;     現在の行のファイルをWindowsに関連付けられたアプリケーションを使っ
;;     て開きます。（わざわざエクスプローラーを開かなくて良くなります。）
;;   * w
;;     現在の行のファイル名をUNIX形式にてコピーします。
;;   * W
;;     現在の行のファイル名をDOS形式にてコピーします。
;;
;;【Tips】
;;  　ファイルを別のディレクトリにコピーしたいときに、まずコピー先のディ
;;　レクトリをDiredで開いて“.”の部分にカーソルを持っていて w を押しま
;;　す。次に、コピーしたいファイルが格納されているディレクトリでファイル
;;　の位置にカーソルを持っていて C を押します。ミニバッファが開くので、
;;　C-y としてコピー先のディレクトリ名をヤンクした後 Enter を押します。
;;
;;【注意】
;;  (1) このスクリプトの中では uenox-dired- という文字列から始まるシンボ
;;    ルを使っています。
;;  (2) Windows98で非ASCII文字列を使ったログイン名でログインした場合にも、
;;    ファイルの所有者が正常に表示されるようにするため、user-login-nameと
;;    user-real-login-nameをsjisでdecodeしています。
;;

;;; Dired で Windows に関連付けられたファイルを起動する。
(defun uenox-dired-winstart()
  "Type '\\[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
	(w32-shell-execute "open" fname)
	(message "win-started %s" fname)
      )
    )
  )

;;; Dired で UNIX 形式でファイル名をコピーする。
(defun uenox-dired-kill-filename-unix()
  "Type '\\[uenox-dired-kill-filename-unix]': copy the current line's filename(unix)."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename))) 
	(kill-new fname)
	(message "%s" fname)
	)
    )
  )

;;; Dired で DOS 形式でファイル名をコピーする。
(defun uenox-dired-kill-filename-dos()
  "Type '\\[uenox-dired-kill-filename-dos]': copy the current line's filename(dos)."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (unix-to-dos-filename (dired-get-filename))))
	(kill-new fname)
	(message "%s" fname)
	)
    )
  )

;;; Dired の起動時にキーボードマップを書き換える。
(add-hook 'dired-mode-hook
	  '(lambda ()
	     (define-key dired-mode-map "\C-j" 'uenox-dired-winstart)
	     (define-key dired-mode-map "w" 'uenox-dired-kill-filename-unix)
	     (define-key dired-mode-map "W" 'uenox-dired-kill-filename-dos)
	     )
	  )

;;; 非ASCII文字列でログインしても Dired で正常に表示されるようにします。
(setq user-login-name (decode-coding-string user-login-name 'sjis))
(setq user-real-login-name (decode-coding-string user-real-login-name 'sjis))