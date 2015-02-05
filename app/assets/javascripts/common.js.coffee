$ ->
  $(document).foundation()

  $(document).on 'ready page:load', ->
    $('time').timeago()
    $('textarea').autosize()

  Turbolinks.enableProgressBar()
  Flash.init()
