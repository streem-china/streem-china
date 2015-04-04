class Reply
  constructor: (id) ->
    @id = id

  delete: ->
    $.ajax '/replies/' + this.id,
      method: 'delete'

$(document).on 'ready page:load', ->
  $('body').on 'click', '.replies .item .reply', ->
    reply_floor = $(this).data('reply-floor')
    reply_user_name = $(this).data('reply-user-name')
    reply_textarea = $('.new_reply textarea')
    new_value = reply_textarea.val() + '#' + reply_floor + I18n.t('reply.floor') + ' @' + reply_user_name + '\n'
    reply_textarea.val(new_value).focus().trigger('autosize.resize')

    false


  $('body').on 'click', '.replies .item .delete', (e) ->
    result = confirm(I18n.t('reply.are_you_sure_delete'))

    if result
      item = $(this).parents('.item')
      reply_floor = item.data('reply-floor')
      reply_id = item.data('reply-id')
      item.fadeOut 300, ->
        item.html('<div class="deleted">' + I18n.t('reply.floor_already_deleted', floor: reply_floor) + '</div>').fadeIn(300)

      Flash.notify(I18n.t('reply.deleted_success'), 'success')

      reply = new Reply(reply_id)

      reply.delete()

    false
