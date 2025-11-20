import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="js-only"
export default class extends Controller {
  connect() {
    for (const toShow of window.document.getElementsByClassName("js-only")) {
      toShow.removeAttribute("aria-hidden")
      toShow.removeAttribute("aria-disables")
      toShow.style["display"] = "inline-block"
    }

    for (const toHide of window.document.getElementsByClassName("nojs-only")) {
      toHide.setAttribute("aria-hidden", "true")
      toHide.setAttribute("aria-disabled", "true")
      toHide.style["display"] = "none"
    }
  }
}
