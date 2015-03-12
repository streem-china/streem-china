class Reply
  @replyFloor: (el) ->
    reply_floor = $(el).data('reply-floor')
    reply_user_name = $(el).data('reply-user-name')
    reply_textarea = $('.new_reply textarea')
    new_value = reply_textarea.val() + '#' + reply_floor + '楼 ' + '@' + reply_user_name + '\n'
    reply_textarea.val(new_value).focus().trigger('autosize.resize')

    false

  @submitByKeyboard: (el, e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      el.parents('form').find('input[type=submit]').trigger('click')

      false

@Reply = Reply

$(document).on 'ready page:load', ->
  $('body').on 'click', '.replies .item .reply', ->
    Reply.replyFloor $(this)

  $('body').on 'keydown', '.reply-form textarea', (e) ->
    Reply.submitByKeyboard $(this), e
