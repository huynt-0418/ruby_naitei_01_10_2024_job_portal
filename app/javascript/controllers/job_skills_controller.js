import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="job-skills"
export default class extends Controller {
  static targets = ["container", "template"]

  addRow(event) {
    event.preventDefault();

    const row = this.templateTarget.content.cloneNode(true);
    this.containerTarget.appendChild(row);
  }

  removeRow(event) {
    event.preventDefault();

    event.currentTarget.closest(".skill-row").remove();
  }
}
