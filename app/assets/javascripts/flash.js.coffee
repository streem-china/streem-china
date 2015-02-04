class Flash
  @notify: (type, message) ->
    flash = '<div class="alert-box ' + type + '" data-alert="">' +
              message                                            +
              '<a class="close" href="#"> &times; </a>'          +
            '</div>'

    $('.fixed-flash-container').html(flash)

    $('.fixed-flash-container').show()

    setTimeout ->
      $('.fixed-flash-container').fadeOut('slow')
    , 3000

@Flash = Flash
