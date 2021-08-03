;; html layer

(load "tag.lisp")

;; html utilities
(defun writeafile (fname objects)
  (with-open-file (out fname
      :direction :output
      :if-exists :supersede)

    (format out "<!DOCTYPE html>~%~a" objects)
  )
)


;; HTML layer

(defun meta (&rest attrs)
  (tag1 :meta attrs)
)

(defun link (&rest attrs)
  (tag1 :link attrs)
)

;<meta charset="UTF-8">
;<meta http-equiv="X-UA-Compatible" content="IE=edge">
;<meta name="format-detection" content="telephone=no">
;<meta name="viewport" content="width=device-width">
(meta :charset "UTF-8")
(meta :http-equiv "X-UA-Compatible" :content "IE=edge")
(meta :name "format-detection" :content "telephone=no")
(meta :name "viewport" :content "width device-width")
(meta :name "viewport" :content "width device-width")

;; other html tags
;;; these functions has no &rest
(defun span (id attrs text)
  (tag :span (append (list :id id) attrs) text)
)

(defun div (id attrs text)
  (tag :div (append (list :id id) attrs) text)
)

(defun divn (id attrs texts)
  (tagn :div (append (list :id id) attrs) texts)
)

;(defun p (conts &rest attrs)
;  (tag :p attrs conts)
;)

