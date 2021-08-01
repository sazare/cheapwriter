;; a sample code

;; if pp? is t or nil, append ~% or none
;; (format nil "~:[~;~%~]"  pp?)

;(defparameter pp? nil)
(defparameter pp? t)

;; utility 
(defun writeafile (fname objects)
  (with-open-file (out fname
      :direction :output
      :if-exists :supersede)

    (format out objects)
  )
)


;; primitives
(defun attributes (attrs)
  (loop with mm = ""
    for np on attrs by #'cddr do
      (setq mm (format nil "~a ~a=\"~a\"" mm (car np)(cadr np)))
    finally
      (return mm)
  )
)

;; tag layer
;; pattern <tag a=b c=d ...>f* g* h*</tag>
(defun tag (name attrs &rest contents) 
  (let ((ats (attributes attrs)))
    (format nil "<~a~a>~{~a ~}</~a>~:[~;~%~]" name ats contents name pp?)
  )
)

(defun tagn (name attrs contents)
  (let ((ats (attributes attrs)))
    (format nil "<~a~a>~{~a ~}</~a>~:[~;~%~]" name ats contents name pp?)
  )
)

;<div class="foo" id="Neko">alphabeta</div>
(tag :div '(:class "foo" :id "Neko") "alphabeta")
(tag :div '(:class "foo" :id "Neko") "alphabeta" "<p>hello</>")

(tagn :div '(:class "foo" :id "Neko") '("alphabeta" "<p>hello</>"))

;; pattern: <tag a=b c=d ...> 
(defun tag1 (name attrs)
  (format nil "<~a~a/>~:[~;~%~]" name (attributes attrs) pp?)
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


;;  user layer lower
(defun my-utf8 ()
  (meta :charset "utf-8")
)

;??
(defun my-style (file)
  (link :rel "stylesheet" :href file)
)

(defun my-title (title)
  (tag :title ()  title)
)

(defun my-head (title)
  (tag :head ()
    (my-utf8)
    (my-style "sample.css")
    (my-title title)
  )
)

(defun my-page (head body)
  (tag :html () head body)
)

(defun my-body (&rest ds)
  (tagn :body  () ds )
)

;; usage1 (my-div0 :abb "hello")
;; usage2 (my-div0 'aaa "hello2")
;; usage3 (my-div0 :xyz "good" :cname "boojum")
;; usage4 (my-div0 :zzz "bad" :cname "stark")

(defun my-div0 (id text &rest attrs)
  (tag :div (append (list :id id) attrs) text)
)


;;  user top layer 
(defun my-doc (mytitle)
  (let (d1 d2 html)
    (my-head "CSSとHTMLの例")
    (setq d1 (my-div0 :line1 "これは最悪" :class "ja"))
    (setq d2 (my-div0 :line2 "ファンタスティック" :class "eja"))

    (setq html (my-page 
                  (my-head mytitle)
                  (my-body d1 d2 d1) ;; this causes 2 same ids.
               )
    )
    html
  )
)

;; doit
(defparameter p1 (my-doc "CSSとHTMLの例"))
(writeafile "my.html" p1)


