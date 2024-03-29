// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import { Turbo } from "@hotwired/turbo-rails";
import "chartkick/chart.js"

document.addEventListener("turbo:load", () => {
  document.getElementById('search_form').addEventListener('ajax:success', (event) => {
    const [data, status, xhr] = event.detail;
    Turbo.renderStreamMessage(data);
  });
});

