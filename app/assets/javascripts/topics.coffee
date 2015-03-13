class Topic

@Topic = Topic

$(document).on 'ready page:load', ->
  $('body').on 'keydown', '.topic-form textarea, .reply-form textarea', (e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      $(this).parents('form').find('input[type=submit]').trigger('click')

      false
