// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { Application } from "@hotwired/stimulus"
import Swiper from 'swiper'
import 'swiper/css'

const application = Application.start()
import "controllers"
