import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="controls"
export default class extends Controller {
  connect() {
    this.#showJsControls()
    this.#hideNoJsControls()
  }

  openPrintDialog() {
    window.print()
  }

  #showJsControls() {
    for (const toShow of window.document.getElementsByClassName("js-control")) {
      toShow.removeAttribute("aria-hidden")
      toShow.removeAttribute("aria-disables")
      toShow.style["display"] = "inline-block"
    }
  }

  #hideNoJsControls() {
    for (const toHide of window.document.getElementsByClassName("nojs-control")) {
      toHide.setAttribute("aria-hidden", "true")
      toHide.setAttribute("aria-disabled", "true")
      toHide.style["display"] = "none"
    }
  }
}
