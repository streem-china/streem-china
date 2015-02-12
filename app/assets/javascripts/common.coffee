$ ->
  $(document).foundation()
  $.timeago.settings.lang = 'zh-CN'
  Turbolinks.enableProgressBar()

  $(document).on 'ready page:load', ->
    if ($('time').length > 0)
      $('time').timeago()
    if ($('textarea').length > 0)
      $('textarea').autosize()
    if ($('.tabs').length > 0)
      $(document).foundation('tab', 'reflow')
    if ($('.flash-container').length > 0)
      Flash.init()
