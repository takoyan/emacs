;;; flutter-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "flutter" "flutter.el" (23778 5044 467788 406000))
;;; Generated autoloads from flutter.el

(autoload 'flutter-run "flutter" "\
Execute `flutter run` inside Emacs.

ARGS is a space-delimited string of CLI flags passed to
`flutter`, and can be nil.  Call with a prefix to be prompted for
args.

\(fn &optional ARGS)" t nil)

(autoload 'flutter-run-or-hot-reload "flutter" "\
Start `flutter run` or hot-reload if already running.

\(fn)" t nil)

(autoload 'flutter-mode "flutter" "\
Major mode for `flutter-run'.

\\{flutter-mode-map}

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; flutter-autoloads.el ends here
