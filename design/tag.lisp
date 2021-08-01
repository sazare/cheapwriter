;; tag layer

;; if pp? is t or nil, append ~% or none
;; (format nil "~:[~;~%~]"  pp?)

;(defparameter pp? nil)
(defparameter pp? t)


;; tag primitives
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

