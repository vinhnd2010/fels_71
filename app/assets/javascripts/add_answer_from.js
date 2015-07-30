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
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require_self
  function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $("#answer_list").append(content.replace(regexp, new_id));
  }

  $(document).ready(function(){
    $("#add-answer-link").click(function(){
      var association = $("#add-answer-link").data("association");
      var content = $("#add-answer-link").data("content");

      content = content.replace(/(\\\")/g, "\"");
      content = content.replace(/(\\n)/g, "");
      content = content.replace(/(\\\/)/g, "/");

      add_fields(null, association, content);
    });
  });
