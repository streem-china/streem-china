class Notification
  constructor: (id) ->
    @id = id

  delete: ->
    $.ajax '/notifications/' + this.id,
      method: 'delete'

$(document).on 'ready page:load', ->
  $('body').on 'click', '.notifications .item .content-deleted a', (e) ->
    notification_id = $(this).data('id')

    $(this).parents('.item').fadeOut 300, -> $(this).remove()

    notification = new Notification(notification_id)

    notification.delete()

  false
