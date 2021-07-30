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
(defun tag (name content) 
  (format nil "<~a>~a</~a>" name content name)
)

(defun html(title)
  (tag 'html 
    (my-title title)
  )
)


(defun meta (&rest attr)
  (loop with mm = "<meta "
    for np on attr by #'cddr do
      (setq mm (format nil "~a ~a=~a" mm (car np)(cadr np)))
    finally
      (return (format nil "~a>" mm))
  )
)

;; sample

;<meta charset="UTF-8">
;<meta http-equiv="X-UA-Compatible" content="IE=edge">
;<meta name="format-detection" content="telephone=no">
;<meta name="viewport" content="width=device-width">
(meta :charset "UTF-8")
(meta :http-equiv "X-UA-Compatible" :content "IE=edge")
(meta :name "format-detection" :content "telephone=no")
(meta :name "viewport" :content="width device-width")



;; 
(defun my-meta ()
  "<meta charset=\"utf-8\">"
)

(defun my-style (file)
  (format nil "<link rel=\"stylesheet\" href=\"~a\">" file)
)

(defun my-title (title)
  (format nil "<title>~a</title>" title)
)

(defun my-head (title)
  (format nil "<head>~a~a~a</head>"
    (my-meta)
    (my-style "sample.css")
    (my-title title)
  )
)

(defun make-html (head body)
  (format nil "<html>~a~a</html>" head body)
)

(defun my-page (head body)
  (make-html head body)
)

(defun make-body (&rest ds)
  (loop with body = "<body>" for di in ds do
    (setq body (format nil "~a ~a" body di))
    finally (return (format nil "~a </body>" body))
  )
)


;; usage1 (make-div :abb "hello")
;; usage2 (make-div 'aaa "hello2")
;; usage3 (make-div :xyz "good" :cname "boojum")
;; usage4 (make-div :zzz "bad" :cname "stark")
(defun make-div (id text &key (cname nil))
  (let ((aid (intern (string id))))
    (if cname (set aid (format nil "<div id=\"~a\" class=\"~a\">~a</div>" aid cname text))
              (set aid (format nil "<div id=\"~a\">~a</div>" aid text)))
  )
)

(defun my-doc (mytitle)
  (let (d1 d2 html)
    (my-head "CSSとHTMLの例")
    (setq d1 (make-div :line1 "これは最悪" :cname :ja))
    (setq d2 (make-div :line2 "ファンタスティック" :cname :eja))

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


