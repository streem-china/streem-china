Array.prototype.unique = ->
  uniqueArray= []

  for e in this
    if $.inArray(e, uniqueArray) < 0
      uniqueArray.push e

  uniqueArray

class @Mention
  constructor: (textarea) ->
    @textarea = textarea

  listenEmoji: ->
    this.textarea.atwho
      at: ':',
      data: window.FavoriteEmojis,
      displayTpl: "<li>" +
                    "<img src='/images/emoji/${filename}'" +
                      "height='20' width='20' style='vertical-align: middle;'/>" +
                        ":${name}:" +
                  "</li>",
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
    mention = new Mention($('.new_reply textarea'))

    mention.listenAll()

  if $('textarea').length
    mention = new Mention($('textarea'))

    mention.listenEmoji()

