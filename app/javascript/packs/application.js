// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import "controllers"
import { initSelect2 } from '../components/init_select2'
import { loadDynamicBannerText } from '../components/search_bar'


Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", () => {
  initSelect2()
  loadDynamicBannerText()

  document.getElementById("search-typed-text").addEventListener("focus", () => {
    document.removeEventListener("turbolinks:load", loadDynamicBannerText)
  })
})


