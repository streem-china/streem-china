$ ->
  $(document).foundation()
  Turbolinks.enableProgressBar()
  I18n.locale = 'zh-CN'
  $.timeago.settings.lang = 'zh-CN'
  $.timeago.settings.strings['zh-CN'] = I18n.translations['zh-CN']['timeago']

  $(document).on 'ready page:load', ->
    if $('time').length
      $('time').timeago()
    if $('textarea').length
      $('textarea').autosize()
    if $('.tabs').length
      $(document).foundation('tab', 'reflow')
