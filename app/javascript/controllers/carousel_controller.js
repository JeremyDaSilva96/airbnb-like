import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "dot"]

  connect() {
    this.currentIndex = 0
    this.updateCarousel()
  }

  prev(event) {
    event.preventDefault()
    event.stopPropagation()
    const totalImages = this.imageTargets.length
    this.currentIndex = (this.currentIndex - 1 + totalImages) % totalImages
    this.updateCarousel()
  }

  next(event) {
    event.preventDefault()
    event.stopPropagation()
    const totalImages = this.imageTargets.length
    this.currentIndex = (this.currentIndex + 1) % totalImages
    this.updateCarousel()
  }

  showImage(event) {
    event.preventDefault()
    event.stopPropagation()
    const index = this.dotTargets.indexOf(event.currentTarget)
    if (index !== -1) {
      this.currentIndex = index
      this.updateCarousel()
    }
  }

  updateCarousel() {
    this.imageTargets.forEach((image, index) => {
      image.classList.toggle("active", index === this.currentIndex)
    })

    this.dotTargets.forEach((dot, index) => {
      dot.classList.toggle("active", index === this.currentIndex)
    })
  }
}
