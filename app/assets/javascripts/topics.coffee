class Topic
  @submitByKeyboard: (el, e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      button = el.parents('form').find('input[type=submit]')

      button.click()

      false

@Topic = Topic

$(document).on 'ready page:load', ->
  $('.topic-form').on 'click', '.preview', ->
    Markdown.convert $(this)

    false

  $('.topic-form').on 'click', '.edit', ->
    Markdown.edit $(this)

    false

  $('.topic-form').on 'keydown', 'textarea', (e) ->
    Topic.submitByKeyboard $(this), e
