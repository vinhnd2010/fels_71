function time_remaining(total_times){
  if (total_times <= 0){
    $("#time-remaining").text(time_over_msg);
    if (total_times == 0){
      $("form").submit();
    }
    $("[type='submit']").remove();
  }else{
    var minutes = Math.floor(total_times / 60);
    var seconds = total_times % 60;
    $("#time-remaining").text(minutes + " : " + seconds);
    setTimeout(function(){time_remaining(total_times - 1)}, 1000);
  }
}

$(document).ready(function(){
  total_times = $("#hidden-data").data("time-remaining");
  time_over_msg = $("#hidden-data").data("time-over-msg");
  time_remaining(total_times);
});
