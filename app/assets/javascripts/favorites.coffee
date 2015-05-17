class @Favorite
  constructor: (favoritable_id, favoritable_type) ->
    @favoritable_id = favoritable_id
    @favoritable_type = favoritable_type

  create: ->
    $.ajax '/favorites.js',
      context: $(this),
      method: 'post'
      data:
        favoritable_id: this.favoritable_id,
        favoritable_type: this.favoritable_type

  delete: ->
    $.ajax '/favorites.js',
      context: $(this)
      method: 'delete'
      data:
        favoritable_id: this.favoritable_id,
        favoritable_type: this.favoritable_type

$(document).on 'ready page:load', ->
  $('body').on 'click', '.favorited', ->
    favoritable_id = $(this).data('favoritable-id')
    favoritable_type = $(this).data('favoritable-type')

    $(this).removeClass('favorited').addClass('unfavorited')
    $(this).removeClass('fa-heart').addClass('fa-heart-o')

    count = parseInt($(this).find('.count').text())
    $(this).find('.count').text(count-1)

    favorite = new Favorite(favoritable_id, favoritable_type)

    favorite.delete()

    false

  $('body').on 'click', '.unfavorited', ->
    favoritable_id = $(this).data('favoritable-id')
    favoritable_type = $(this).data('favoritable-type')

    $(this).removeClass('unfavorited').addClass('favorited')
    $(this).removeClass('fa-heart-o').addClass('fa-heart')

    count = parseInt($(this).find('.count').text())
    $(this).find('.count').text(count+1)

    favorite = new Favorite(favoritable_id, favoritable_type)

    favorite.create()

    false

  $('body').on 'click', '.activity #favorites .delete', ->
    result = confirm(I18n.t('favorite.are_you_sure_delete'))

    if result
      favoritable_id = $(this).data('favoritable-id')
      favoritable_type = $(this).data('favoritable-type')
      $(this).parents('.item').fadeOut 300, -> $(this).remove()

      Flash.notify(I18n.t('favorite.deleted_success'), 'success')

      favorite = new Favorite(favoritable_id, favoritable_type)

      favorite.delete()

    false

  $('body').on 'click', '.activity #favorites .content-deleted a', (e) ->
    favoritable_id = $(this).data('favoritable-id')
    favoritable_type = $(this).data('favoritable-type')

    $(this).parents('.item').fadeOut 300, -> $(this).remove()

    favorite = new Favorite(favoritable_id, favoritable_type)

    favorite.delete()

    false
