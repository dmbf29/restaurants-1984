import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="character-counter"
export default class extends Controller {
  static targets = ["counter"];
  connect() {}

  update(event) {
    const input = event.currentTarget;
    // get the number of characters from....
    const num = input.value.length;
    // put the number... in the text
    this.counterTarget.innerText = `${num}/10 characters`;
  }
}
