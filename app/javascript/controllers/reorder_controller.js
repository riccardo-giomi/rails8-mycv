import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = { url: String }

  dragStart(event) {
    this.dragging = event.target.closest("[data-reorder-target='item']")
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", this.dragging.dataset.id)
  }

  dragEnd() {
    this.dragging = null
  }

  dragOver(event) {
    event.preventDefault() // required, the browser never fires "drop"
    if (!this.dragging) return

    const target = event.target.closest("[data-reorder-target='item']")
    if (!target || target === this.dragging) return

    const dy = event.clientY - target.getBoundingClientRect().top
    const after = dy > target.offsetHeight / 2
    target.parentNode.insertBefore(this.dragging, after ? target.nextSibling : target)
  }

  drop(event) {
    event.preventDefault()
    this.persistOrder()
  }

  persistOrder() {
    const headers = { "Content-type": "application/json" }
    // crsf-token can be absent during tests depending on configuration.
    const csrfToken = document.querySelector("meta[name='csrf-token']")?.content
    if (csrfToken) headers["X-CSRF-Token"] = csrfToken

    fetch(this.urlValue, {
      method: "PATCH",
      headers,
      body: JSON.stringify({ ids: this.itemTargets.map(item => item.dataset.id) })
    })
      .then(() => { this.element.dataset.reorderComplete = Date.now() })
      .catch((error) => { this.element.dataset.reorderError = error.message })
  }
}
