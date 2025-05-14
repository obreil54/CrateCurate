import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="avatar-preview"
export default class extends Controller {
  static targets = ["image", "input"]
  connect() {
    console.log("Avatar preview controller connected")
  }

  updatePreview() {
    console.log("Updating avatar preview")
    const file = this.inputTarget.files[0]
    console.log(file)
    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result
      }
      reader.readAsDataURL(file)
    }
  }
}