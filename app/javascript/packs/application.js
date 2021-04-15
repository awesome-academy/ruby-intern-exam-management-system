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
global.toastr = require("toastr")
