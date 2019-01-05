
;;
;; Build systems
;;

;; These jam systems are here more for reference than for actual use by anyone other than me
(defun build-universal-jam ()
  "Build using jam (select directory first)"
  (interactive)
  (message "Building using Jam")
  (let ((default-directory (read-directory-name "Directory: ")))
	(compile
	 "jam -j4 -q")
	)
  )

(defun build-universal-jam-clean ()
  "Build using jam (select directory first)"
  (interactive)
  (message "Jam clean")
  (let ((default-directory (read-directory-name "Directory: ")))
	(compile
	 "jam clean")
	)
  )

;;
;; Build system manager - select from multiple different compilation commands
;;

;; Note that names need to be unique (they should be anyways)
(setq macoy-build-system-list (list
							   '("Jam (current directory)" build-universal-jam)
							   '("Jam Clean (current directory)" build-universal-jam-clean)
							   )
	  )

(setq macoy-build-system-default nil)

;; TODO: Figure out why this doesn't work
(defun macoy-build-system-build ()
  "Build the build system defined in `macoy-build-system-default'"
  (interactive)
  (unless macoy-build-system-default
	(message "No default build system selected. Run macoy-build-system-select-then-build")
	)
  (when macoy-build-system-default
	(message "Building %s" (car macoy-build-system-default))
	(let ((build-function (nth 1 macoy-build-system-default)))
	  (call-interactively build-function)
	  )
	)
  )

(defun macoy-build-system-select ()
  "Select default build system using Ido"
  (interactive)
;; Use Ido to pick the build system
  (let ((build-system-ido-list nil) (selected-build-system nil))
	(message "Going to build list")
	;; Build a list of only the names of build systems
	(dolist (build-system macoy-build-system-list build-system-ido-list)
	  (add-to-list 'build-system-ido-list (car build-system))
	  )
	(message "build list completed, going to set selected-build-system via Ido")
	;; Let the user select the build system using Ido
	(setq selected-build-system (ido-completing-read "Build system: " build-system-ido-list))
	(message "Build system set; finding by string and setting the default")
	(dolist (build-system macoy-build-system-list)
	  (when (string-equal selected-build-system (car build-system))
		(setq macoy-build-system-default build-system)
		)
	  )
	)
  )

(defun macoy-build-system-select-then-build ()
  "Select a build from `macoy-build-system-list' and build it"
  (interactive)
  (call-interactively 'macoy-build-system-select)
  
  ;; Execute the build
  (macoy-build-system-build)
  )

(global-set-key (kbd "<f7>") 'macoy-build-system-build)
(global-set-key (kbd "S-<f7>") 'macoy-build-system-select-then-build)

;; Doesn't work because it needs to select the buffer. This shouldn't happen for search results too, but would
;; (defun macoy-on-compilation-mode ()
  ;; (end-of-buffer)
  ;; )

;; (add-hook 'compilation-mode-hook 'macoy-on-compilation-mode)