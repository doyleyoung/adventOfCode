(ns nice-strings.core
  (:gen-class))

(defn is_nice [string]
  (if (not (= (re-find #"ab|cd|pq|xy" string) nil))
    false
    (if (= (re-find #"(\w)\1" string) nil)
        false
        (if (>= (count (re-seq #"[aeiou]" string)) 3)
          true
          false)))
)

(defn part_one [input]
  (count (filter is_nice input))
)

(defn is_refined_nice [string]
  (if (= (re-find #"(\w\w).*?\1" string) nil)
    false
    (if (= (re-find #"(\w)\w\1" string) nil)
        false
        true))
)


(defn part_two [input]
  (count (filter is_refined_nice input))
)

(defn -main
  "Determine naughty and nice strings from input"
  [args]
  (let [input (clojure.string/split-lines (slurp args))]
    ;; answer 258
    (println (str "Nice strings: " (part_one input)))
    ;; answer 53
    (println (str "Nice strings two: " (part_two input))))
)

