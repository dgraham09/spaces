import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import rangePlugin from "flatpickrRangePlugin"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = [
    "start_date",
    "end_date"
  ]

  static values = {
    disabledDates: Array
  }

  connect() {
    flatpickr(this.start_dateTarget,
      {
        "plugins": [new rangePlugin({ input: this.end_dateTarget})],
        "dateFormat": "Y-m-d",
        "disable": this.disabledDatesValue,
        "enable": [
          {
            from: "2023-08-25",
            to: "2025-05-01"
          }
        ]

      })
    // Add option config
  }
}
