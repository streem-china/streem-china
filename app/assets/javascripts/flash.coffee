class @Flash
  @notify: (message, type) ->
    flash = '<div class="fixed">'                                                   +
              '<div class="row small-collapse medium-uncollapse large-uncollapse">' +
                '<div class="small-12 column flash-container">'                     +
                  '<div class="alert-box ' + type + '" data-alert="">'              +
                    message                                                         +
                    '<a class="close" href="#"> &times; </a>'                       +
                  '</div>'                                                          +
                '</div>'                                                            +
              '</div>'                                                              +
            '</div>'

    $('.container').prepend(flash)
    $('.flash-container').foundation('alert', 'reflow')

    setTimeout ->
      $('.flash-container').fadeOut('slow').parent('fixed').remove()
    , 3000
