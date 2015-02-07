$ ->
  $(document).foundation()
  Turbolinks.enableProgressBar()
  $.timeago.settings.lang = 'zh-CN'

  $(document).on 'ready page:load', ->
    $('time').timeago()
    $('textarea').autosize()
    Flash.init()
