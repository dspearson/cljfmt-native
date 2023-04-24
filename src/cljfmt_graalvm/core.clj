(ns cljfmt-graalvm.core
  (:require [cljfmt.main :as cljfmt])
  (:gen-class))

(defn -main
  [& args]
  (apply cljfmt/-main args))
