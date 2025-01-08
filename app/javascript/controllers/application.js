export { application }

import { Application } from "@hotwired/stimulus"
import Flatpickr from "stimulus-flatpickr"

// Import style for flatpickr
require("flatpickr/dist/flatpickr.css")

const application = Application.start()
application.register("flatpickr", Flatpickr)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
