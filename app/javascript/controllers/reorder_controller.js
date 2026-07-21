import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = { url: String }

  dragStart(event) {
    this.dragging = event.target.closest("[data-reorder-target='item']")
    // Otherwise, moving downward inserts the card directly under the cursor,
    // which then hit-tests to the dragging card itself on the next dragover
    // and stalls further movement in that direction.
    this.dragging.style.pointerEvents = "none"
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", this.dragging.dataset.id)
  }

  dragEnd() {
    if (this.dragging) this.dragging.style.pointerEvents = ""
    this.dragging = null
  }

  dragOver(event) {
    event.preventDefault() // required, the browser never fires "drop"
    if (!this.dragging) return

    this.autoScroll(event.clientY)

    const target = event.target.closest("[data-reorder-target='item']")
    if (!target || target === this.dragging) return

    // Entries can be tall enough that a 50/50 split falls below the fold, so
    // the threshold favors whichever direction the drag is already coming
    // from: moving down only needs to clear the target's own top (its full
    // height was already crossed getting here); moving up mirrors that near
    // the target's bottom.
    const rect = target.getBoundingClientRect()
    const dy = event.clientY - rect.top
    const movingDown = !!(this.dragging.compareDocumentPosition(target) & Node.DOCUMENT_POSITION_FOLLOWING)
    const threshold = rect.height * (movingDown ? 0.25 : 0.75)
    const after = dy > threshold

    target.parentNode.insertBefore(this.dragging, after ? target.nextSibling : target)
  }

  autoScroll(clientY) {
    const margin = 100
    const speed = 10

    if (clientY < margin) {
      window.scrollBy(0, -speed)
    } else if (clientY > window.innerHeight - margin) {
      window.scrollBy(0, speed)
    }
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
