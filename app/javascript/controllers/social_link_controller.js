import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="social-link"
export default class extends Controller {
  static targets = ["row", "addButton", "socialLinkForm"]

  connect() {
    this.rowCount = this.rowTargets.length
  }

  addRow(event) {
    event.preventDefault()
    const newRow = this.rowTargets[0].cloneNode(true)
    newRow.querySelectorAll("input, select").forEach(input => input.value = "")
    this.socialLinkFormTarget.appendChild(newRow)
    this.rowCount++
  }

  removeRow(event) {
    event.preventDefault()
    const row = event.target.closest(".row")
    const destroyField = row.querySelector("[data-destroyfield]");
    console.log(destroyField)
    if (destroyField) {
      destroyField.value = "1"
    }
    row.style.display = "none"
  }
}
