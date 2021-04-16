import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import I18n from "i18n-js/index.js.erb"
import "bootstrap"
require("jquery")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
window.I18n = I18n
toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "3000",
  "extendedTimeOut": "1000",
  "showEasing": "show",
  "hideEasing": "show",
  "showMethod": "show",
  "hideMethod": "show"
}
global.toastr = require("toastr")
