$ ->
  $(document).foundation()

  $(document).on 'ready page:load', ->
    $('textarea').autosize()
    $.timeago.settings.lang = 'zh-CN'
    $('time.timeago').timeago()

  Turbolinks.enableProgressBar()
