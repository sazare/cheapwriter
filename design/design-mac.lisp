;; a sample code

(load "html.lisp")

(defparameter pp? nil)
;(defparameter pp? t)

;; my page definition

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


