(defproject cljfmt-graalvm "1.0.0"
  :description "cljfmt wrapper for GraalVM native-image"
  :license {:name "ISC"}
  :dependencies [[org.clojure/clojure "1.11.1"]
                 [cljfmt "0.9.2"]]

  :main ^:skip-aot cljfmt-graalvm.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}
             :native-image {:name "your-executable-name"
               :opts ["--initialize-at-build-time"
                      "--no-fallback"
                      "--no-server"
                      "--report-unsupported-elements-at-runtime"
                      "--allow-incomplete-classpath"]
               :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})
