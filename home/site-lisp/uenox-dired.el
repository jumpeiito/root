;;; -*- Mode: Emacs-Lisp ; Coding: iso-2022-jp-dos -*-
;;
;; uenox-dired.el : Dired ���[�h���g������ Emacs Lisp �X�N���v�g
;; Copyright (C) 2000 UENO Tetsuyuki
;;
;; �{�v���O�����̓t���[�E�\�t�g�E�F�A�ł��B
;; �@���Ȃ��́AFree Software Foundation�����\����GNU ��ʌ��L�g�p������
;;�u�o�[�W�����Q�v�����͂���ȍ~�̊e�o�[�W�����̒����炢���ꂩ��I�����A
;; ���̃o�[�W��������߂�����ɏ]���Ė{�v���O�������ĔЕz�܂��͕ύX����
;; ���Ƃ��ł��܂��B
;; �@�{�v���O�����͗L�p�Ƃ͎v���܂����A�Еz�ɂ������ẮA�s�ꐫ�y�ѓ���
;; �ړI�K�����ɂ��Ă̈Öق̕ۏ؂��܂߂āA�����Ȃ�ۏ؂��s�Ȃ��܂���B
;; �ڍׂɂ��Ă�GNU ��ʌ��L�g�p�����������ǂ݂��������B
;; �@���Ȃ��́A�{�v���O�����ƈꏏ��GNU��ʌ��L�g�p�����̎ʂ����󂯎����
;; ����͂��ł��B�����łȂ��ꍇ�́A
;;   Free Software Foundation, Inc.,
;;   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA 
;; �֎莆�������Ă��������B
;;
;; �����: ��� �N�K "UENO Tetsuyuki" <uenox@black.livedoor.com>
;; �ŏ��: 1.00
;; �쐬�����F2000/10/21
;; �z�z�ꏊ: http://uenox.infoseek.livedoor.net/elisp/uenox-dired.el
;;
;;
;;�y�����z
;;  ��L�̔z�z�ꏊ����t�@�C�����_�E�����[�h���āA�z�[���f�B���N�g��("~")
;;  �Ɋi�[���Ă��������B
;;
;;�y�ݒ�z
;;  �������t�@�C�� .emacs �Ɉȉ��̍s�����������Ă��������B
;;    (setq load-path (cons "~" load-path))
;;    (load "uenox-dired")
;;
;;�y�����z
;;  Dired �Ɉȉ���3�̋@�\���ǉ�����܂��B�i�L�[�}�b�v�͂��̃t�@�C����
;;  �Ō�̕������������邱�ƂŕύX�ł��܂��B�j
;;   * C-j 
;;     ���݂̍s�̃t�@�C����Windows�Ɋ֘A�t����ꂽ�A�v���P�[�V�������g��
;;     �ĊJ���܂��B�i�킴�킴�G�N�X�v���[���[���J���Ȃ��ėǂ��Ȃ�܂��B�j
;;   * w
;;     ���݂̍s�̃t�@�C������UNIX�`���ɂăR�s�[���܂��B
;;   * W
;;     ���݂̍s�̃t�@�C������DOS�`���ɂăR�s�[���܂��B
;;
;;�yTips�z
;;  �@�t�@�C����ʂ̃f�B���N�g���ɃR�s�[�������Ƃ��ɁA�܂��R�s�[��̃f�B
;;�@���N�g����Dired�ŊJ���āg.�h�̕����ɃJ�[�\���������Ă��� w ��������
;;�@���B���ɁA�R�s�[�������t�@�C�����i�[����Ă���f�B���N�g���Ńt�@�C��
;;�@�̈ʒu�ɃJ�[�\���������Ă��� C �������܂��B�~�j�o�b�t�@���J���̂ŁA
;;�@C-y �Ƃ��ăR�s�[��̃f�B���N�g�����������N������ Enter �������܂��B
;;
;;�y���Ӂz
;;  (1) ���̃X�N���v�g�̒��ł� uenox-dired- �Ƃ��������񂩂�n�܂�V���{
;;    �����g���Ă��܂��B
;;  (2) Windows98�Ŕ�ASCII��������g�������O�C�����Ń��O�C�������ꍇ�ɂ��A
;;    �t�@�C���̏��L�҂�����ɕ\�������悤�ɂ��邽�߁Auser-login-name��
;;    user-real-login-name��sjis��decode���Ă��܂��B
;;

;;; Dired �� Windows �Ɋ֘A�t����ꂽ�t�@�C�����N������B
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

;;; Dired �� UNIX �`���Ńt�@�C�������R�s�[����B
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

;;; Dired �� DOS �`���Ńt�@�C�������R�s�[����B
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

;;; Dired �̋N�����ɃL�[�{�[�h�}�b�v������������B
(add-hook 'dired-mode-hook
	  '(lambda ()
	     (define-key dired-mode-map "\C-j" 'uenox-dired-winstart)
	     (define-key dired-mode-map "w" 'uenox-dired-kill-filename-unix)
	     (define-key dired-mode-map "W" 'uenox-dired-kill-filename-dos)
	     )
	  )

;;; ��ASCII������Ń��O�C�����Ă� Dired �Ő���ɕ\�������悤�ɂ��܂��B
(setq user-login-name (decode-coding-string user-login-name 'sjis))
(setq user-real-login-name (decode-coding-string user-real-login-name 'sjis))