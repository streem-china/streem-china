class @Markdown
  constructor: (ele, text) ->
    @ele = ele
    @text = text

  convert: ->
    if this.text
      $.ajax '/markdown/convert',
        method: 'post',
        context: this,
        data:
          text: this.text,
        success: (data) ->
          this.ele.find('.body').html(data.html)
    else
      this.ele.find('.body').html('')

$(document).on 'ready page:load', ->
  $('body').on 'click', '.reply-form .preview, .topic-form .preview', ->
    $(this).removeClass('preview').addClass('edit')
    $(this).removeClass('fa-eye').addClass('fa-pencil')

    previewer = '<div class="previewer">'                     +
                  '<div class="body">'                        +
                    '<span class="loading">loading...</span>' +
                  '</div>'                                    +
                '</div>'

    textarea = $(this).parents('form').find('textarea')

    $(previewer).insertBefore(textarea).css('min-height', textarea.css('height'))

    textarea.hide()

    markdown = new Markdown($('.previewer'), textarea.val())

    markdown.convert()

    false

  $('body').on 'click', '.reply-form .edit, .topic-form .edit', ->
    $(this).removeClass('edit').addClass('preview')
    $(this).removeClass('fa-pencil').addClass('fa-eye')

    $('.previewer').remove()

    $(this).parents('form').find('textarea').show()

    false
