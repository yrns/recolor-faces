;; Copyright (c) 2016 Al McElrath

(require 'dash)
(require 'dash-functional)

(defvar solarized-colors
  (list "#002b36" "#073642" "#586e75" "#657b83" "#839496" "#93a1a1"
        "#eee8d5" "#fdf6e3" "#b58900" "#cb4b16" "#dc322f" "#d33682"
        "#6c71c4" "#268bd2" "#2aa198" "#859900" "#7B6000" "#DEB542"
        "#8B2C02" "#F2804F" "#990A1B" "#FF6E64" "#93115C" "#F771AC"
        "#3F4D91" "#9EA0E5" "#00629D" "#69B7F0" "#00736F" "#69CABF"
        "#546E00" "#B4C342"))

(defun match-faces (re colors)
  "Update every face matching RE to use colors from COLORS."
  (-each (-filter (lambda (f) (string-match re (face-name f))) (face-list))
    (lambda (face)
      (update-face :foreground face colors)
      (update-face :background face colors))))

(defun update-face (attr face colors)
  "If FACE has attr (color), replace it with a color from list."
  (-when-let (c (face-attribute-specified-or (face-attribute face attr) nil))
    (set-face-attribute face nil attr (closest-color c colors))))

(defun closest-color (color list)
  "Return the closest color to COLOR in LIST."
  (-min-by (-on '> (-partial 'color-distance color)) list))

;; etc.
(match-faces "^diredp-" solarized-colors)
