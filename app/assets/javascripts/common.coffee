$ ->
  $(document).foundation()
  Turbolinks.enableProgressBar()
  $.timeago.settings.lang = 'zh-CN'
  I18n.locale = 'zh-CN'

  $(document).on 'ready page:load', ->
    if $('time').length
      $('time').timeago()
    if $('textarea').length
      $('textarea').autosize()
    if $('.tabs').length
      $(document).foundation('tab', 'reflow')
