// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require select2
//= require angular
//= require_directory ./angular
//= require_directory ./angular/services
//= require_directory ./angular/controllers

$(document).ready(function() {
  $('a[rel=popover]').popover();
  $('.tooltip').tooltip();
  $('a[rel=tooltip]').tooltip();
  // $('.matches-predictions .chzn-select').chosen({disable_search: true});

  $('.matches-predictions select').on('change', function() {
      var $form =  $(this).closest('form');
      $form.submit();
      // var method = $form.attr('method') ? $form.attr('method').toUpperCase() : 'POST';
      // $.ajax({
      //     url: $form.attr('action'),
      //     data: $form.serialize(),
      //     type: method,
      //     success: function() {
      //     }
      // });
  });
});
