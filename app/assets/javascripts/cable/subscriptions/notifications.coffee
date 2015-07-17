App.cable.subscriptions.create 'NotificationsChannel',
  received: (data) ->
    unread_notifications_count = data.unread_notifications_count

    if unread_notifications_count == 0
      $('.unread-notifications-count').removeClass('alert').addClass('secondary')
    else
      $('.unread-notifications-count').removeClass('secondary').addClass('alert')

    $('.unread-notifications-count').text(unread_notifications_count)
