'use strict'

/*
 * Invoke the functions when the DOM is ready.
 */
$(document).ready(function () {

  // disable jupyter environments missing jupyter- lab
  if ($('#batch_connect_session_context_python_version').length > 0) {
    Array.from(document.querySelector("#batch_connect_session_context_python_version").options).forEach(function (option_element) {
      let option_value = option_element.value;
      if (!option_value.localeCompare("No Jupyter Lab")) {
        option_element.disabled = true;
      }
    });
  }
});
