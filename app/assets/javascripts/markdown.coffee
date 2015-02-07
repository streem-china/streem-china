class Markdown
  @preview: (el) ->
    preview_box_html = '<div class="preview-box"><div class="body"></div></div>'
    loading_html = '<span class="loading">loading...</span>'
    form = $(el).parents('form')
    textarea = form.find('textarea')
    $(preview_box_html).insertBefore(textarea)
    el.parent().addClass('hide')
    form.find('.edit').parent().removeClass('hide')
    preview_box = form.find('.preview-box')
    preview_box.css('min-height', textarea.css('height')).find('.body').html(loading_html)
    textarea.addClass('hide')

    $.post '/markdown/preview',
      text: textarea.val()
      (data) ->
        preview_box.find('.body').html(data.html)

  @edit: (el) ->
    el.parent().addClass('hide')
    form = $(el).parents('form')
    form.find('.preview').parent().removeClass('hide')
    form.find('.preview-box').remove()
    textarea = form.find('textarea').removeClass('hide')

@Markdown = Markdown
