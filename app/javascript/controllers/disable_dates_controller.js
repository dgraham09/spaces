import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disable-dates"
export default class extends Controller {

  static values = {
    disabledDates: String
  }
  connect() {
  }
}
