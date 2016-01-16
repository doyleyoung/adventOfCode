(ns floor.core
  (:gen-class))

(defn value [x] 
    (if (= \( x) 1 -1))

(defn end-floor [x]
  (reduce + (map value x))
)
 
(defn first-negative [count sum parens]
  (if (empty? parens)
    "never"
    (if (< (+ sum (value (first parens))) 0)
      (+ count 1)
      (recur (+ count 1) (+ sum (value (first parens))) (rest parens)))))

(defn -main
  "Pass me a string containing parenthesis ( = +1, ) = -1"
  [args]
  (do
    (println (str "Last floor: " (end-floor args)))
    (println (str "Enter basement at step: " (first-negative 0 0 args)))))


