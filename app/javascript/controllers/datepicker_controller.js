import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    console.log("connected!");

    // when it connects, find the input and activate flatpickr
    // this.element -> it's the HTML element we put the controller on
    flatpickr(this.element);
  }
}
