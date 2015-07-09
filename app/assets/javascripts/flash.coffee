class @Flash
  @notify: (message, type) ->
    $('.flash').remove()

    flash = "<div class='flash'>"                                         +
              "<div class='row small-collapse medium-uncollapse'>"        +
                "<div class='column'>"                                    +
                  "<div class='alert-box #{type}' data-alert=''>"         +
                    message                                               +
                    "<a href='#' class='close'>&times;</a>"               +
                  "</div>"                                                +
                "</div>"                                                  +
              "</div>"                                                    +
            "</div>"

    if $(document).scrollTop()
      $('.container').prepend(flash)

      $('.flash').addClass('fixed').css('z-index', 9999)

      $('.flash .column').css('top', 0).css('opacity', .9)
    else
      $('.flash').css('z-index', 9999)

      $('.container').prepend(flash)

    $('.flash').foundation('alert', 'reflow')

    setTimeout ->
      $('.flash').fadeOut()
    , 5000

$(document).on 'ready page:load', ->
  $(document).scroll ->
    if $(document).scrollTop()
      unless $('.flash').hasClass('fixed')
        $('.flash').addClass('fixed')
        $('.flash .column').css('opacity', .9)
    else
      if $('.flash').hasClass('fixed')
        $('.flash').removeClass('fixed')
        $('.flash .column').css('opacity', 1)
