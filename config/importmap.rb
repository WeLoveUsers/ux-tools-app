# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js", preload: true
pin "jquery-ujs", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js", preload: true
pin "semantic-ui", to: "https://cdn.jsdelivr.net/npm/fomantic-ui@2.9.0/dist/semantic.min.js", preload: true
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.js"
pin "trix", to: "https://ga.jspm.io/npm:trix@2.0.3/dist/trix.esm.min.js"
pin "progressbar", to: "progressbar_js/progressbar.min.js"
pin "screenfull", to: "screenfull/screenfull.min.js"
pin "timer", to: "timer_js/timer.min.js"

pin "app_timer", preload: true
pin "app_projects", preload: true
pin "app_public", preload: true
pin "app_users", preload: true
pin "app_util", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"
