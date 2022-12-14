# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js", preload: true
pin "jquery-ujs", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js", preload: true
pin "semantic-ui", to: "https://cdn.jsdelivr.net/npm/fomantic-ui@2.9.0/dist/semantic.min.js", preload: true
pin "trix", to: "https://ga.jspm.io/npm:trix@2.0.3/dist/trix.esm.min.js"

pin "app_projects", preload: true
pin "app_public", preload: true
pin "app_users", preload: true
pin "app_util", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"
