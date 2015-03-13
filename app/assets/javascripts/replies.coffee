class Reply
  @delete: (reply_id) ->
    $.ajax '/replies/' + reply_id,
      method: 'delete'

@Reply = Reply

$(document).on 'ready page:load', ->
  $('body').on 'click', '.replies .item .reply', ->
    reply_floor = $(this).data('reply-floor')
    reply_user_name = $(this).data('reply-user-name')
    reply_textarea = $('.new_reply textarea')
    new_value = reply_textarea.val() + '#' + reply_floor + '楼 ' + '@' + reply_user_name + '\n'
    reply_textarea.val(new_value).focus().trigger('autosize.resize')


  $('body').on 'click', '.replies .item .delete', (e) ->
    result = confirm('确定删除该回复?')

    if result
      item = $(this).parents('.item')
      reply_floor = item.data('reply-floor')
      reply_id = item.data('reply-id')
      item.fadeOut 300, ->
        item.html('<div class="deleted">' + reply_floor + ' 楼已删除' + '</div>').fadeIn(300)

      Flash.notify('success', '删除成功')

      Reply.delete(reply_id)

    false
