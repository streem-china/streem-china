class Favorite
  @favorite: (favoritable_id, favoritable_type) ->
    $.ajax '/favorites.js',
      method: 'post'
      data:
        favoritable_id: favoritable_id,
        favoritable_type: favoritable_type

  @unfavorite: (favoritable_id, favoritable_type) ->
    $.ajax '/favorites.js',
      method: 'delete'
      data:
        favoritable_id: favoritable_id,
        favoritable_type: favoritable_type

@Favorite = Favorite

$(document).on 'ready page:load', ->
  $('body').on 'click', '.favorited', ->
    favoritable_id = $(this).data('favoritable-id')
    favoritable_type = $(this).data('favoritable-type')

    $(this).removeClass('favorited')
      .addClass('unfavorited')
      .find('i')
      .removeClass('fa-heart')
      .addClass('fa-heart-o')

    count = parseInt($(this).find('.count').text())
    $(this).find('.count').text(count-1)

    Favorite.unfavorite(favoritable_id, favoritable_type)

  $('body').on 'click', '.unfavorited', ->
    favoritable_id = $(this).data('favoritable-id')
    favoritable_type = $(this).data('favoritable-type')

    $(this).removeClass('unfavorited')
      .addClass('favorited')
      .find('i')
      .removeClass('fa-heart-o')
      .addClass('fa-heart')

    count = parseInt($(this).find('.count').text())
    $(this).find('.count').text(count+1)

    Favorite.favorite(favoritable_id, favoritable_type)

  $('body').on 'click', '.activity #favorites .delete', ->
    result = confirm('确定删除该收藏?')

    if result
      favoritable_id = $(this).data('favoritable-id')
      favoritable_type = $(this).data('favoritable-type')
      $(this).parents('.item').fadeOut 300, ->
        $(this).remove()

      Favorite.unfavorite(favoritable_id, favoritable_type)
