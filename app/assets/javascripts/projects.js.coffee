datePicker = (selector) ->
  $real = $(selector)
  $display = $real.clone().attr({class: null, id: null, name: null})
  $real.hide()
  $display.insertBefore($real)
  $display.datepicker({altField: $real, altFormat: 'yy-mm-dd'})

$ ->
  datePicker("#log_log_date")

