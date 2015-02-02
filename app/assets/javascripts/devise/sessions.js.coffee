$(document).on 'page:load', ->
  $('.login-box .action .button').click ->
    $(this).text('Github 登陆中...')
    $(this).addClass('disabled', 'disabled')
