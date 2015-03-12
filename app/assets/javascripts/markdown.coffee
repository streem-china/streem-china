class Markdown
  @convert: (el, text) ->
    $.post '/markdown/convert',
      text: text,
      (data) ->
        el.find('.body').html(data.html)

@Markdown = Markdown

$(document).on 'ready page:load', ->
  $('body').on 'click', '.reply-form .preview, .topic-form .preview', ->
    $(this).removeClass('preview fa-eye').addClass('edit fa-pencil')

    previewer = '<div class="previewer">'                     +
                  '<div class="body body-small">'             +
                    '<span class="loading">loading...</span>' +
                  '</div>'                                    +
                '</div>'

    textarea = $(this).parents('form').find('textarea')
    $(previewer).insertBefore(textarea)
    $('.previewer').css('min-height', textarea.css('height'))
    textarea.hide()

    Markdown.convert($('.previewer'), textarea.val())

  $('body').on 'click', '.reply-form .edit, .topic-form .edit', ->
    $(this).addClass('preview fa-eye').removeClass('edit fa-pencil')
    $('.previewer').remove()
    $(this).parents('form').find('textarea').show()
