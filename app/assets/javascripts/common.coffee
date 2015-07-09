$ ->
  Turbolinks.enableProgressBar()
  I18n.locale = 'zh-CN'
  $.timeago.settings.lang = 'zh-CN'
  $.timeago.settings.strings['zh-CN'] = I18n.translations['zh-CN']['timeago']
  $(document).foundation()

$(document).on 'ready page:load', ->
  if $('time').length
    $('time').timeago()
  if $('textarea').length
    $('textarea').autosize()
  if $('.tabs').length
    $(document).foundation('tab', 'reflow')
  if $('.has-tooltip').length
    $(document).foundation('tooltip', 'reflow')
  if $('.toggle-topbar').length
    $(document).foundation('topbar', 'reflow')

  $('.search #q').focus ->
    $(this).animate
      'margin-right': '100px'
  .focusout ->
    $(this).animate
      'margin-right': 0
