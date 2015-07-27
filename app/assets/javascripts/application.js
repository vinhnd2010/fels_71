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
  $(document).ready(function(){
    $("div.alert").delay(3000).slideUp();
    $(".button-click").click(function(){
      add_fields($(this)[0], $(this).data("fields"));
    });
  });

  $(document).ready(function(){
    $("#user_avatar").bind("change", function() {
      var size_in_megabytes = this.files[0].size/1048576;
      if (size_in_megabytes > 5) {
        alert("Maximum file size is 5MB. Please choose a smaller file.");
      }
    });
  });

  function remove_fields(field) {
    $(field).prev().val("true");
    $(field).parent().hide();
  }

  function add_fields(link, content) {
    var new_id = new Date().getTime();
    var expression = "[0-9]+";
    var regexp = new RegExp(expression, "g");
    $(link).parent().before(content.replace(regexp, new_id));
  }

