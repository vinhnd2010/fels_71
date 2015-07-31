jQuery ->
  $(".button-remove").click (e) ->
    e.preventDefault()
    $(this).closest("div.answer-form").remove()
