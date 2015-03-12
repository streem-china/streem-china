class Topic
  @submitByKeyboard: (el, e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      button = el.parents('form').find('input[type=submit]')

      button.click()

@Topic = Topic

$(document).on 'ready page:load', ->
  $('body').on 'keydown', '.topic-form textarea', (e) ->
    Topic.submitByKeyboard $(this), e
