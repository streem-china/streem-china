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


  if ('.new_reply textarea').length > 0
    usernames = $.unique $('.username').map ->
      return($(this).text())
    .get()

    $('.new_reply textarea').atwho({ at: '@', data: usernames })

    emojis = [
      { name: '+1',         unicode: '1f44d' },
      { name: '-1',         unicode: '1f44e' },
      { name: 'heart',      unicode: '2764'  },
      { name: 'clap',       unicode: '1f44f' },
      { name: 'smile',      unicode: '1f604' },
      { name: 'joy',        unicode: '1f602' },
      { name: 'scream',     unicode: '1f631' },
      { name: 'sparkles',   unicode: '2728'  },
      { name: 'cold_sweat', unicode: '1f630' },
      { name: 'shit',       unicode: '1f4a9' }
    ]

    $('.new_reply textarea').atwho({
      at: ':',
      data: emojis,
      displayTpl: "<li><img src='/images/emoji/unicode/${unicode}.png' height='20' width='20' style='vertical-align: middle;'/> :${name}: </li>",
      insertTpl: ":${name}:"
    })

    floors= $('.floor').map ->
      return($(this).text())
    .get().reverse()

    $('.new_reply textarea').atwho({ at: '#', data: floors })
