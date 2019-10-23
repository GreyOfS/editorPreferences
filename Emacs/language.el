(setq macoy-edict-location "C:/Users/mmadson/MacoyPrograms/Emacs27_Win64_WithDeps/dependencies/edict/edict")
(setq macoy-kanjidict-location nil)

(add-to-list 'auto-coding-alist '("edict\\'" . euc-jp))
(add-to-list 'auto-coding-alist '("kanjidic\\'" . euc-jp))

;; From https://www.emacswiki.org/emacs/UsingEdict
(defun macoy-find-region-translation-japanese (start end)
  "Find the region in the EDICT file."
  (interactive "r")
  (let ((str (buffer-substring-no-properties start end))
	(conf (current-window-configuration)))
    (if (and macoy-kanjidict-location (= (length str) 1))
	(find-file  macoy-kanjidict-location)
      (find-file macoy-edict-location))
    (goto-char (point-min))
    (when (occur str)
      (set-window-configuration conf)
      (switch-to-buffer "*Occur*")
      (local-set-key (kbd "q") 'bury-buffer))))
