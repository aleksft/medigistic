var init_medicine_lookup;

init_medicine_lookup = function() {
  $('#medicine-lookup-form').on('ajax:before', function(event, data, status) {
    show_spinner();
  });

  $('#medicine-lookup-form').on('ajax:after', function(event, data, status) {
    hide_spinner();
  });

  $('#medicine-lookup-form').on('ajax:success', function(event, data, status) {
    $('#medicine-lookup').replaceWith(data);
    init_medicine_lookup();
  });

  $('#medicine-lookup-form').on('ajax:error', function(event, xhr, status, error) {
    hide_spinner();
    $('#medicine-lookup-results').replaceWith('');
    $('#medicine-lookup-errors').replaceWith('Medicine was not found.');
  });
}

$(document).ready(function() {
  init_medicine_lookup();
  })
