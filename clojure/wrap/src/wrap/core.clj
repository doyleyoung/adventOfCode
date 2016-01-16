(ns wrap.core
  (:gen-class))

(defn parse-int [s]
  (Integer. (re-find  #"\d+" s )))

(defn split-lines [input]
  (map #(clojure.string/split % #"x") (clojure.string/split-lines input)))

(defn surface-area [[l w h]]
  (+ (* l w 2) (* l h 2) (* w h 2)))

(defn slack [[l w h]]
  (let [dims (sort (list l w h))]
    (* (first dims) (first (rest dims)))))

(defn paper [[l w h]]
  (let [lwh (map parse-int [l w h])]
    (+ (surface-area lwh) (slack lwh)))
)

(defn smallest-perimeter [[l w h]]
  (let [dims (sort (list l w h))]
    (+ (* (first dims) 2) (* (first (rest dims)) 2))))

(defn bow [[l w h]]
    (* l w h))

(defn ribbon [[l w h]]
  (let [lwh (map parse-int [l w h])]
    (+ (smallest-perimeter lwh) (bow lwh))))

(defn -main
  "Determine required wrapping paper"
  [args]
  (let [input (split-lines (slurp args))]
    (println (str "Wrapping paper:") (reduce + (map paper input)))
    (println (str "Ribbon:") (reduce + (map ribbon input))))
)
