$(document).on 'ready page:load', ->
  $('.new_reply textarea').keydown (e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      $('.new_reply input[type=submit]').click()

  $('.replies').on 'click', '.item .reply a', ->
    reply_floor = $(this).data('reply-floor')
    reply_user_name = $(this).data('reply-user-name')

    old_value = $('.new_reply textarea').val()
    new_value = $('.new_reply textarea').val() + '#' + reply_floor + '楼 ' + '@' + reply_user_name + '\n'

    $('.new_reply textarea').val(new_value).focus().autosize().trigger('autosize.resize')

    return false
