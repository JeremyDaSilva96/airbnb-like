import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import { French } from "flatpickr/dist/l10n/fr.js"

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    this.fp = flatpickr(this.element, {
      locale: French,
      altInput: true,
      altFormat: "d/m/Y",
      dateFormat: "Y-m-d",
      minDate: "today",
    })
  }

  disconnect() {
    this.fp.destroy()
  }
}
