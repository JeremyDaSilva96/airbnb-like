import { Controller } from "@hotwired/stimulus"
import { Carousel } from "bootstrap"

export default class extends Controller {
  connect() {
    // Initialize Bootstrap carousel
    this.carousel = new Carousel(this.element, {
      interval: false // Disable auto-sliding
    })

    // Prevent link navigation when clicking carousel controls
    this.element.querySelectorAll('.carousel-control-prev, .carousel-control-next, .carousel-indicators button').forEach(control => {
      control.addEventListener('click', (e) => {
        e.preventDefault()
        e.stopPropagation()
      })
    })
  }

  disconnect() {
    if (this.carousel) {
      this.carousel.dispose()
    }
  }
}
