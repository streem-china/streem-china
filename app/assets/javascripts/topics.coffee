class Topic
  @preview: (el) ->
    Markdown.preview(el)

    false

  @edit: (el) ->
    Markdown.edit(el)

    false

  @submitByKeyboard: (el, e) ->
    if (e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey
      button = el.parents('form').find('input[type=submit]')

      button.click()

      false

@Topic = Topic

$(document).on 'ready page:load', ->
  $('.topic-form').on 'click', '.preview', ->
    Topic.preview $(this)

  $('.topic-form').on 'click', '.edit', ->
    Topic.edit $(this)

  $('.topic-form').on 'keydown', 'textarea', (e) ->
    Topic.submitByKeyboard $(this), e
