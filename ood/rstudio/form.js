'use strict'

/*
 * Invoke the functions when the DOM is ready.
 */
$(document).ready(function () {
  if ($('#batch_connect_session_context_slurm_accounts option').length == 0) {
    $('input[name="commit"]').prop("disabled",true);
  }
});
