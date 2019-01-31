
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;
;; Added by Macoy
;;

;; Macoy's .emacs
;; Goal: Make a dev environment with Sublime Text 3-like keybindings and features:
;; - [Done] Code completion
;; - [Done] Goto definition
;; - [Done] Multiple cursors
;; - [Done] Templates
;; - [Done] Workspaces ("desktops" by emacs terminology)
;; - [Done] Build systems
;;   - [Done] One keypress builds
;;   - [Done] Quick jump to compilation error
;;   - [Done] Easy add build system
;; - [Done] Fuzzy file opening
;; - [Done] Fuzzy editor command execution
;; - [Done] Standard clipboard behavior (no copy on mark, no copy on kill etc., only on C-c!)

;; Ways Emacs excels over Sublime:
;; - More keyboard-only friendly
;; - More configurable
;; - Registers (for positions and saving strings)
;; - More minimal appearance
;; - Built-in help (Sublime's documentation can be spotty; Emacs docs can be too complicated)

;; Setup (more for my own help than anyone else's)
;; Copy the contents of emacsConfig.txt to .emacs
;; Set the user-init-dir in your .emacs to the directory of my .el files. This can load my config files straight from the repository.
;; 1. Install all packages in emacsPackages.txt
;; 2. Add macoyCopy, macoyCut, and macoyPaste to mc/cmds-to-run-once and restart Emacs
;; 3. For magit on windows, fix credentials for server folder:
;;        https://stackoverflow.com/questions/885793/emacs-error-when-calling-server-start
;; 4. Setup magit credentials:
;;        https://stackoverflow.com/questions/22580873/how-can-i-configure-magit-to-use-my-github-user-name
;; 5. If you want to use codesearch (fancy ultra fast indexed code searching), install it:
;;        https://github.com/google/codesearch
;;    ...then set codesearch-csearch-exe and codesearch-cindex-exe to their respective executable locations
;;    Search for codesearch in this file to adjust indexing settings

;; TODO (there are more scattered around this file; * = more important):
;; - TAGS has to be set up per-project; doesn't allow cross-repository finding afaik
;;       It does, you just need to set tags-table-list.
;;       See https://www.gnu.org/software/emacs/manual/html_node/emacs/Select-Tags-Table.html
;; - Would be nice to have buffers and files merged like Sublime's C-p (but not essential)
;; - Tab key behavior confuses me especially in plaintext files
;; - Get back and forward working (back doesn't work too well)
;; - Determine what smooth-scrolling actually does (if anything)
;; - Copy line when nothing is marked
;; - Multiple cursors copy and cut when whole line selected
;; - Ido jump to file anywhere does more harm than good (especially when creating new files)
;;   This can be disabled with (setq ido-auto-merge-work-directories-length -1)
;; - Python indentation is troublesome in originally poorly formatted files
;; - Auto-install packages just by loading .emacs
;;   (use-package? https://github.com/jwiegley/use-package but I don't want to get locked in)
;; - Shortcuts:
;;    Toggle whitespace mode
;;    Swap windows (see http://whattheemacsd.com/ rotate windows?)
;; - Indent-tabs-mode only in C/C++
;; - Auto-select actual struct definition when multiple xref results
;; - If use-region, C-k should delete region instead of line
;; - Powerline: Make mode colors comments so they aren't as bright (same color as percent complete)
;; - tags-query-replace use marked for tag to replace
;; - Recover from commit failed backup command (or at least quick-open recovery file)
;; - Fix windows OpenSSL/TLS support
;; - Jump copy thing at point then paste back at start
;;   e.g. the macro would avy prompt, jump to destination, copy it, then go back and paste it at start mark
;;   Is this just a problem with autocomplete not being fast enough?
;;*  - This is probably a better solution: what if there are two autocomplete pools, one for function
;;       or file-local symbols only which immediately prompts with dropdown (after a character)?
;;       This could maybe work as some sort of delay hook: if I'm typing immediately show me file-local
;;       source, but if I type and pause for N seconds enable the full tags source
;;   Learn how to do custom mode for jumping back
;; - Expand-region does strange things with the region. Eg. C-s-' after moving cursor, expand region then type over (damn it; it went away after re-evaluating .emacs)
;; - Start using Abbrev more
;; - It seems like iy-goto-char will eventually trip me up in its temporary mode (so far it's fine)
;; - Seems like it would be cool to have a "copy to references" thing which would take marked and
;;   put it in a references.org file or something for deep code reading dives (what about projects?)
;; - Command to close all dired buffers
;; - User-specific emacs configs (see http://whattheemacsd.com/ "Need different settings for different machines")
;; - Make it so mark is cleared if arrow key away (has to do with expand-region)
;; - Find file in dir (basically ido find file but actually useful; how does it work?)
;; - Macoy-Codesearch should have something for whole word searches as well as sanitizing regex symbols
;;   I tried to do this but it doesn't work :/
;; - Isearch: Make reversing the isearch not find the same thing again
;; - Isearch: Always put cursor at end of search (try searching backwards; it'll put it at the front)
;; - Isearch: If you paste a thing into isearch, then go up or down a bit, then hit backspace, it returns
;;    to the last search until you get to the original place, then it clears the search. This is confusing :(
;; - Mysterious thing which deletes the last half of the buffer (c-remove-stale-state-cache-backwards?)
;; - Codesearch: Regex filtering doesn't work (try e.g. "myfunc(") (TODO: Retest this with the new "quotes")
;; - Fix window splitting on Linux/4k
;; - Feature: filter lines in file (good for codesearch results etc.). Extra cool = as you type (hard) (install something for this)
;;   keep-lines does this, although not as you type, and requires modifying the buffer (make a func which dupes and does it)
;;   Use (clone-indirect-buffer) (https://www.gnu.org/software/emacs/manual/html_node/emacs/Indirect-Buffers.html)?
;; - Treacherous: vc-annotate uses the revision which the buffer has, which if you commit from DSVN
;;   does not update (i.e. look at the mode line revision). You need to revert the buffer then do vc-annotate to see the true state
;; - Isearch: Customize colors
;; - Search Everything/projectile-find-files which will work on non-vc dirs
;; - Code reference to org: mark block of code, run command; command copies string to clipboard with file:line org link and code block. Good for deep dives where you have to take notes
;; - Quick shortcut to switch to header/source file

;; Split todo
;; - Put all things which are user-specific at the top of respective files
;; - Search: Make Codesearch data folder user-specific

;; Criticism improvements:
;; - [DONE] Select word at point
;; - [DONE] Reopen closed file
;; - [DONE-ish] Get find references working
;; - [DONE] Autorevert if no modifications (do tell me in modeline that this happened)
;; - [DONE] Faster/better Ag
;; - [DONE] Swiper is too damn slow
;;   Eventually make tags-search and tags-loop-continue async and list results in a buffer
;; - Faster browse symbols (first, figure out where most symbols come from and eliminate; then separate projects?)
;;   Separate lists by first letter for x26 speedup? (kindof defeats purpose if not knowing first letter)
;;   Copy swiper-all requiring multiple letters? (this doesn't seem to help too much)

;; Emacs Notes
;; C-h k <the keybind> to find what a key does
;; C-h b to list all bindings (should've used this more when fighting binds...)
;; C-q = quoted-insert "insert the next character, whatever it is" e.g. useful for inserting a tab
;; describe-char with cursor over character will say where the font face came from (useful for theming)
;; Use ibuffer to select and kill many buffers. kill-some-buffers is also okay
;; Use ediff-revision to easily manipulate working edits
;; Use re-builder to create a regex by seeing the results of it in the current buffer (super awesome)
;; Hit C-f while in ido to disable all completion (for when you're fighting it)
;; Amazing multiline editing: C-f to isearch-forward, then C-a to see all results, then e to edit all lines
;; diff-buffer-with-file to see a diff of current (unsaved) modifications

;; Used to load separate configuration files I've created. Order matters so they're scattered a bit
(setq user-init-dir "~/.emacs.d/macoy")
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;; BAD THING
;;
;; This is the worst thing ever. Remap keys so I can use C-c and C-x how I damn well please.
;; Subsequently, read C-u as my C-x and C-y as my C-c (yes, it sucks and is confusing as hell.
;; I blame the developers.
;;
(keyboard-translate ?\C-u ?\C-x)
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-y ?\C-c)
(keyboard-translate ?\C-c ?\C-y)

;; This is a stupid hack around an apparent bug in edebug.
;; If set, don't define C-x anywhere. If C-x is defined then edebug complains about it not being a prefix key
;; You'll need to restart in order for it to work
;; Update: After keyboard-translate, this is no longer an issue. Leaving here in case I go back on keyboard-translate
(setq macoy-edebug-prefix-hack nil)

;; Simpleclip makes system clipboard and emacs kill ring separate
;; This is sane copy paste behavior
;; I keep this near the top because many of my utilities rely on simpleclip
(when (require 'simpleclip)
  (simpleclip-mode 1)
  )

;; Settings which affect the core behavior of Emacs as well as interface-changing things like ido
;; This also has random utilities for managing buffers and files
;; This should remain early in load order
(load-user-file "core-settings.el")

;; Various customizations for Org mode
(load-user-file "org-customizations.el")

;; Org-drill and associated customizations
(load-user-file "drill-customizations.el")

;; Make it easier to create and switch desktops
(load-user-file "desktop-management.el")

;; Utilities for getting around in files (quick jump, saving points, etc.)
(load-user-file "navigation.el")

;; Various different ways to search
(load-user-file "search.el")

;; Tools for auto-formatting code, default formatting settings, etc.
(load-user-file "code-formatting.el")

;; All things tags and autocompletion
(load-user-file "tags-and-autocompletion.el")

;; Modes and customizations of modes for different syntaxes
(load-user-file "syntaxes.el")

;; Customizations related to source control stuff like DSVN, Magit, etc.
(load-user-file "source-control.el")

;; Various compile commands and build system management
(load-user-file "build-systems.el")

;; Cut/copy/paste and multiple cursors stuff
(load-user-file "clipboard.el")

;; Keybindings for various modes
;; Note that not all keybinds are defined in this file
(load-user-file "keybinds.el")

;; Visual customizations which are okay to occur before the theme has been set in custom-set-variables
(load-user-file "visual-early.el")

;; Stuff unique to certain machines (mine here for reference)
(when (or (string-equal (user-login-name) "macoy")
		  (string-equal (user-login-name) "mmadson"))
  (load-file "~/.emacs-this-machine-only.el")
  )

;;
;; Hand-written by Macoy end
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(ansi-term-color-vector
   [unspecified "#ffffff" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#4271ae" "#4d4d4c"] t)
 '(custom-enabled-themes '(base16-my-auto))
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(ediff-split-window-function 'split-window-horizontally)
 '(emms-mode-line-icon-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };"))
 '(fci-rule-color "#383838")
 '(gnus-logo-colors '("#2fdbde" "#c0c0c0") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };") t)
 '(large-file-warning-threshold 60000000)
 '(linum-format " %7i ")
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-drill))
 '(org-support-shift-select t)
 '(package-archives
   (quote
	(("gnu" . "http://elpa.gnu.org/packages/")
	 ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   '(web-mode rainbow-mode ivy-xref expand-region ivy engine-mode diminish iy-go-to-char magit dsvn delight adaptive-wrap web-beautify etags-select simpleclip yasnippet swiper company auto-complete clang-format avy ag xah-find flx-ido ido-vertical-mode sublime-themes smooth-scrolling alect-themes base16-theme powerline darktooth-theme projectile smex fiplr helm-dash better-defaults multiple-cursors zenburn-theme marmalade-demo))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8")
 '(projectile-globally-ignored-directories
   '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "AutoGen" "obj140"))
 '(projectile-indexing-method 'native)
 '(tab-width 4)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
	 (40 . "#CC9393")
	 (60 . "#DFAF8F")
	 (80 . "#D0BF8F")
	 (100 . "#E0CF9F")
	 (120 . "#F0DFAF")
	 (140 . "#5F7F5F")
	 (160 . "#7F9F7F")
	 (180 . "#8FB28F")
	 (200 . "#9FC59F")
	 (220 . "#AFD8AF")
	 (240 . "#BFEBBF")
	 (260 . "#93E0E3")
	 (280 . "#6CA0A3")
	 (300 . "#7CB8BB")
	 (320 . "#8CD0D3")
	 (340 . "#94BFF3")
	 (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))

;;
;; Macoy late visual customizations (put here to play nice with themes)
;;

;; Visual customization which should happen after theme has been set
(load-user-file "visual-late.el")

;;
;; Macoy Handwritten end
;;

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
