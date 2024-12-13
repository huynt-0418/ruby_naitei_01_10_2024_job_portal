import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="technology-manager"
export default class extends Controller {
  static targets = ["input", "list", "technologies"];

  connect() {
    this.technologies = JSON.parse(this.technologiesTarget.value || "[]");
    this.technologies.forEach(technology => this.renderTechnology(technology));
  }

  add(event) {
    event.preventDefault();
    const technology = this.inputTarget.value.trim();

    if (technology === "" || this.technologies.includes(technology)) {
      this.inputTarget.value = ""; 
      return;
    }

    this.technologies.push(technology); 
    this.renderTechnology(technology); 
    this.updateTechnologies(); 
    this.inputTarget.value = ""; 
  }

  remove(event) {
    const technology = event.target.dataset.technology;
    this.technologies = this.technologies.filter(t => t !== technology); 
    event.target.closest(".badge").remove();
    this.updateTechnologies()
  }

  updateTechnologies() {
    this.technologiesTarget.value = JSON.stringify(this.technologies);
    console.log(this.technologiesTarget.value);
  }

  renderTechnology(technology) {
    const badge = document.createElement("span");
    badge.className = "badge bg-primary me-2 text-center fs-6";
    badge.innerHTML = `${technology} <button type="button" class="btn-close btn-close-white btn-sm text-white" aria-label="Remove" data-technology="${technology}" data-action="click->technology-manager#remove"></button>`;
    this.listTarget.appendChild(badge);
  }
}
