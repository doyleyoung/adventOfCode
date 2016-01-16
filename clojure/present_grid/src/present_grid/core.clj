(ns present-grid.core
  (:gen-class))

(defn santa_visited [visited x y [direction & remaining]]
  (if (empty? (str direction))
    (count visited)
    (case direction
      \^ (recur (conj visited (list x (+ y 1))) x (+ y 1) remaining)
      \v (recur (conj visited (list x (- y 1))) x (- y 1) remaining)
      \> (recur (conj visited (list (+ x 1) y)) (+ x 1) y remaining)
      \< (recur (conj visited (list (- x 1) y)) (-  x 1)  y remaining)
      (recur visited x y remaining)))
)

;; this is ugly, im ashamed
(defn sr_visited [visited sx sy rx ry turn [direction & remaining]]
  (if (empty? (str direction))
    (count visited)
    (case direction
      \^ (if (= turn "santa")
           (recur (conj visited (list sx (+ sy 1))) sx (+ sy 1) rx ry "robot" remaining)
           (recur (conj visited (list rx (+ ry 1))) sx sy rx (+ ry 1) "santa" remaining))
      \v (if (= turn "santa")
           (recur (conj visited (list sx (- sy 1))) sx (- sy 1) rx ry "robot" remaining)
           (recur (conj visited (list rx (- ry 1))) sx sy rx (- ry 1) "santa" remaining))
      \> (if (= turn "santa")
           (recur (conj visited (list (+ sx 1) sy)) (+ sx 1) sy rx ry "robot" remaining)
           (recur (conj visited (list (+ rx 1) ry)) sx sy (+ rx 1) ry "santa" remaining))
      \< (if (= turn "santa")
           (recur (conj visited (list (- sx 1) sy)) (- sx 1) sy rx ry "robot" remaining)
           (recur (conj visited (list (- rx 1) ry)) sx sy (- rx 1) ry "santa" remaining))
      (recur visited sx sy rx ry turn remaining)))
)

(defn -main
  "Determine santa's visited path and both santa and robot santas visited path"
  [args]
  (let [input (seq (slurp args))]
    ;; answer 2572
    (println (str "Santa alone: ") (santa_visited #{'(0 0)} 0 0 input))
    ;; answer 2631
    (println (str "Santa and robot: ") (sr_visited #{'(0 0)} 0 0 0 0 "santa" input))
))
