import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = ["goTop", "goBottom"]

  connect() {
    this.#updateControls()

    window.addEventListener("scroll", () => {
      this.#updateControls()
    })
  }

  goTop(e) {
    e.preventDefault()
    window.scrollTo(0, 0)
  }

  goBottom(e) {
    e.preventDefault()
    window.scrollTo(0, document.documentElement.offsetHeight)
  }

  #updateControls() {
    if (this.#contentIsOverflowingTop) {
      this.#enable(this.goTopTarget)
    } else {
      this.#disable(this.goTopTarget)
    }

    if (this.#contentIsOverflowingBottom) {
      this.#enable(this.goBottomTarget)
    } else {
      this.#disable(this.goBottomTarget)
    }
  }

  #enable(target, handler) {
    target.removeAttribute("aria-disabled")
  }

  #disable(target) {
    target.setAttribute("aria-disabled", "true")
  }

  get #contentIsOverflowingTop() {
    return window.scrollY > 0
  }

  get #contentIsOverflowingBottom() {
    const content = document.documentElement
    return content.offsetHeight > content.clientHeight + window.scrollY
  }
}
