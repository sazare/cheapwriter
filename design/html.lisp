;; html layer

(load "tag.lisp")

;; html utilities
(defun writeafile (fname objects)
  (with-open-file (out fname
      :direction :output
      :if-exists :supersede)

    (format out objects)
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


