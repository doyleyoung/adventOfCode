(ns floor.core-test
  (:require [clojure.test :refer :all]
            [floor.core :refer :all]))

(deftest value-tests
  (testing "Value of ("
    (is (= (value \() 1)))
  (testing "Value of )"
    (is (= (value \)) -1))))

(deftest end-floor-tests
  (testing "End floor of '('"
    (is (= (end-floor "(") 1)))
  (testing "End floor of ')'"
    (is (= (end-floor ")") -1)))
  (testing "End floor of '()'"
    (is (= (end-floor "()") 0)))
  (testing "End floor of '(('"
    (is (= (end-floor "((") 2)))
  (testing "End floor of '))'"
    (is (= (end-floor "))") -2))))

(deftest first-negative-tests
  (testing "First negative of '('"
    (is (= (first-negative 0 0 "(") "never")))
  (testing "First negative of ')'"
    (is (= (first-negative 0 0 ")") 1)))
  (testing "First negative of '()'"
    (is (= (first-negative 0 0 "()") "never")))
  (testing "First negative of '(('"
    (is (= (first-negative 0 0 "((") "never")))
  (testing "First negative of '))'"
    (is (= (first-negative 0 0 "))") 1)))
  (testing "First negative of '((())))"
    (is (= (first-negative 0 0 "((())))") 7))))


