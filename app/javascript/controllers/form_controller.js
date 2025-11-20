import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    const submitActions = document.getElementsByClassName("submit-action")

    for (const action of submitActions) {
      action.onclick = (e) => {
        e.preventDefault()
        this.save()
      }
    }
  }

  save() {
    this.formTarget.submit()
  }
}
