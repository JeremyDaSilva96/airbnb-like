import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "dot"]
  static values = { images: Array }

  connect() {
    this.index = 0
    this.updateCarousel()
  }

  prev(event) {
    event.preventDefault()
    event.stopPropagation()
    const totalImages = this.imagesValue.length || this.imageTargets.length
    this.index = (this.index - 1 + totalImages) % totalImages
    this.updateCarousel()
  }

  next(event) {
    event.preventDefault()
    event.stopPropagation()
    const totalImages = this.imagesValue.length || this.imageTargets.length
    this.index = (this.index + 1) % totalImages
    this.updateCarousel()
  }

  showImage(event) {
    if (event) {
      event.preventDefault()
      event.stopPropagation()
      const index = this.dotTargets.indexOf(event.currentTarget)
      if (index !== -1) {
        this.index = index
      }
    }
    this.updateCarousel()
  }

  updateCarousel() {
    if (this.imagesValue && this.imagesValue.length > 0) {
      // If using images value array
      this.imageTargets[0].src = this.imagesValue[this.index]
    } else {
      // If using multiple image targets
      this.imageTargets.forEach((image, index) => {
        image.classList.toggle("active", index === this.index)
      })
    }

    // Update navigation dots
    if (this.hasDotTarget) {
      this.dotTargets.forEach((dot, index) => {
        dot.classList.toggle("active", index === this.index)
      })
    }
  }
}
