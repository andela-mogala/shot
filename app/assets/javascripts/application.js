// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets

$(document).ready(function() {
  setTimeout(function() {
    $('#notice_wrapper').fadeOut('slow', function() {
      $(this).remove();
    });
  }, 4500);

  $('[data-toggle = "tooltip"]').tooltip();

  $('#btn_copy').on('click', function(){
    copyToClipboard($('#copy_target'));
    });
  });

  $('#btn_copy').click( function() {
    setTimeout(function() {
      $('#copy_alert').fadeOut('slow', function() {
        $(this).remove();
      });
    }, 4500);
  });


function copyToClipboard(element) {
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();
}