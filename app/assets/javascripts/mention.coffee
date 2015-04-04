Array.prototype.unique = ->
  uniqueArray= []

  for e in this
    if $.inArray(e, uniqueArray) < 0
      uniqueArray.push e

  uniqueArray

class @Atwho
  constructor: (textarea) ->
    @textarea = textarea

  favoriteEmojis: [
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

  listenEmoji: ->
    this.textarea.atwho
      at: ':',
      data: this.favoriteEmojis,
      displayTpl: "<li><img src='/images/emoji/unicode/${unicode}.png' height='20' width='20' style='vertical-align: middle;'/> :${name}: </li>",
      insertTpl: ":${name}:"

  listenFloor:  ->
    floors= $('.floor').map (i, ele) ->
      $(ele).text()
    .get().reverse()

    this.textarea.atwho({ at: '#', data: floors })

  listenUsername: ->
    usernames = $('.username').map (i, ele) ->
      $(ele).text()
    .get().unique().reverse()

    this.textarea.atwho({ at: '@', data: usernames })

  listenAll: ->
    this.listenEmoji(this.textarea)
    this.listenFloor(this.textarea)
    this.listenUsername(this.textarea)

$(document).on 'ready page:load', ->
  if $('.new_reply textarea').length
    atwho = new Atwho($('.new_reply textarea'))

    atwho.listenAll()

  if $('textarea').length
    atwho = new Atwho($('textarea'))

    atwho.listenEmoji()

