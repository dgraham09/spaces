import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import rangePlugin from "flatpickrRangePlugin"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = [
    "start_date",
    "end_date"
  ]
  connect() {
    flatpickr(this.start_dateTarget,
      {
        "plugins": [new rangePlugin({ input: this.end_dateTarget})]
      })
    // Add option config
  }
}
