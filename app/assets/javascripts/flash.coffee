class Flash
  @init: ->
    setTimeout ->
      $('.flash-container').fadeOut('slow')
    , 3000

  @notify: (type, message) ->
    flash = '<div class="fixed">'                                                   +
              '<div class="row small-collapse medium-uncollapse large-uncollapse">' +
                '<div class="small-12 column fixed-flash-container">'               +
                  '<div class="alert-box ' + type + '" data-alert="">'              +
                    message                                                         +
                    '<a class="close" href="#"> &times; </a>'                       +
                  '</div>'                                                          +
                '</div>'                                                            +
              '</div>'                                                              +
            '</div>'

    $('body .container').prepend(flash)
    $('.fixed-flash-container').parent('fixed').show()
    $('.fixed-flash-container').foundation('alert', 'reflow')

    setTimeout ->
      $('.fixed-flash-container').fadeOut('slow')
      $('.fixed-flash-container').parent('fixed').remove()
    , 3000

@Flash = Flash
