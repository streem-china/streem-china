Array.prototype.unique = ->
  uniqueArray= []

  for e in this
    if $.inArray(e, uniqueArray) < 0
      uniqueArray.push e

  return uniqueArray

class Atwho
  @favoriteEmojiList = [
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

  @listenEmoji: (textarea) ->
    textarea.atwho({
      at: ':',
      data: Atwho.favoriteEmojiList,
      displayTpl: "<li><img src='/images/emoji/unicode/${unicode}.png' height='20' width='20' style='vertical-align: middle;'/> :${name}: </li>",
      insertTpl: ":${name}:"
    })

  @listenFloor: (textarea) ->
    floors= $('.floor').map ->
      return($(this).text())
    .get().reverse()

    textarea.atwho({ at: '#', data: floors })

  @listenUsername: (textarea) ->
    usernames = $('.username').map ->
      return($(this).text())
    .get().unique().reverse()

    textarea.atwho({ at: '@', data: usernames })

  @listenAll: (textarea) ->
    Atwho.listenEmoji(textarea)
    Atwho.listenFloor(textarea)
    Atwho.listenUsername(textarea)

@Atwho = Atwho

$(document).on 'ready page:load', ->
  if $('.new_reply textarea').length
    Atwho.listenAll($('.new_reply textarea'))

  if $('textarea').length
    Atwho.listenEmoji($('textarea'))

