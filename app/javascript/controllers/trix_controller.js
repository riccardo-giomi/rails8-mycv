// Shamelessly copied from this Medium article:
// https://medium.com/@makenakong/how-to-add-and-customize-the-trix-editor-for-your-ruby-on-rails-application-c0a5d3082254#05a2
// Tons of thanks to the author.
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trix"
export default class TrixController extends Controller {
  static UNUSED_TOOLBAR_CLASSES = [".trix-button-group--file-tools"]

  connect() {
    addEventListener("trix-initialize", function (event) {
      TrixController.UNUSED_TOOLBAR_CLASSES.forEach((cls) => {
        document.querySelector(cls).remove()
      });
    }, true)

    addEventListener("trix-file-accept", function (event) {
      event.preventDefault()
    }, true)
  }
}
