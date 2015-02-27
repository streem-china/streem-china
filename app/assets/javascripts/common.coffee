$ ->
  $(document).foundation()
  $.timeago.settings.lang = 'zh-CN'
  Turbolinks.enableProgressBar()

  $(document).on 'ready page:load', ->
    if $('time').length
      $('time').timeago()
    if $('textarea').length
      $('textarea').autosize()
    if $('.tabs').length
      $(document).foundation('tab', 'reflow')
    if $('.flash-container').length
      Flash.init()
