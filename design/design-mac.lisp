;; a sample code

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
(defun tag (name attrs &rest contents) 
  (let ((ats (attributes attrs)))
    (format nil "<~a~a>~{~a ~}</~a>" name ats contents name)
  )
)

(defun tagn (name attrs contents)
  (let ((ats (attributes attrs)))
    (format nil "<~a~a>~{~a ~}</~a>" name ats contents name)
  )
)

;<div class="foo" id="Neko">alphabeta</div>
(tag :div '(:class "foo" :id "Neko") "alphabeta")
(tag :div '(:class "foo" :id "Neko") "alphabeta" "<p>hello</>")

(tagn :div '(:class "foo" :id "Neko") '("alphabeta" "<p>hello</>"))


(defun tag1 (name attrs)
  (format nil "<~a~a>" name (attributes attrs))
)


;; html layer
(defun html(title)
  (tag 'html () (my-title title)
  )
)
(defun meta (&rest attrs)
  (tag1 :meta attrs)
)

(defun link (attrs)
  (tag1 :link attrs)
)

;(defun meta0 (&rest attr)
;  (format nil "<meta ~a>" (attributes attr))
;)
;; sample

;<meta charset="UTF-8">
;<meta http-equiv="X-UA-Compatible" content="IE=edge">
;<meta name="format-detection" content="telephone=no">
;<meta name="viewport" content="width=device-width">
(meta :charset "UTF-8")
(meta :http-equiv "X-UA-Compatible" :content "IE=edge")
(meta :name "format-detection" :content "telephone=no")
(meta :name "viewport" :content "width device-width")
(meta "name" "viewport" "content" "width device-width")



;;  customize
(defun my-meta ()
  (meta :charset "utf-8")
)

(defun my-style (file)
  (tag1 :link (list :rel "stylesheet" :href file))
)

(defun my-title (title)
  (tag :title ()  title)
)

(defun my-head (title)
  (tag :head ()
    (my-meta)
    (my-style "sample.css")
    (my-title title)
  )
)

(defun make-html (head body)
  (tag :html () head body)
)

(defun my-page (head body)
  (make-html head body)
)

(defun make-body (&rest ds)
  (tagn :body  () ds )
)

;; usage1 (make-div :abb "hello")
;; usage2 (make-div 'aaa "hello2")
;; usage3 (make-div :xyz "good" :cname "boojum")
;; usage4 (make-div :zzz "bad" :cname "stark")

(defun make-div0 (id text &rest attrs)
  (tag :div (append (list :id id) attrs) text)
)

;(defun make-div (id text &rest attrs)
;  (let ((aid (intern (string id))))
;    (if cname (set aid (format nil "<div id=\"~a\" class=\"~a\">~a</div>" aid cname text))
;              (set aid (format nil "<div id=\"~a\">~a</div>" aid text)))
;  )
;)

(defun my-doc (mytitle)
  (let (d1 d2 html)
    (my-head "CSSとHTMLの例")
    (setq d1 (make-div0 :line1 "これは最悪" :class "ja"))
    (setq d2 (make-div0 :line2 "ファンタスティック" :class "eja"))

    (setq html (my-page 
                  (my-head mytitle)
                  (make-body d1 d2 d1)
               )
    )
    html
  )
)



(defparameter p1 (my-doc "CSSとHTMLの例"))
(writeafile "my.html" p1)


