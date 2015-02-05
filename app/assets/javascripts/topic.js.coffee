$(document).on 'ready page:load', ->
  $('.new_reply textarea').keydown (e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      $('.new_reply input[type=submit]').click()
