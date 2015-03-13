class Markdown
  @convert: (el, text) ->
    if text
      $.post '/markdown/convert',
        text: text,
        (data) ->
          el.find('.body').html(data.html)
    else
      el.find('.body').html('')

@Markdown = Markdown

$(document).on 'ready page:load', ->
  $('body').on 'click', '.reply-form .preview, .topic-form .preview', ->
    $(this).removeClass('preview').addClass('edit')
    $(this).find('i').removeClass('fa-eye').addClass('fa-pencil')

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
    $(this).removeClass('edit').addClass('preview')
    $(this).find('i').removeClass('fa-pencil').addClass('fa-eye')
    $('.previewer').remove()
    $(this).parents('form').find('textarea').show()
