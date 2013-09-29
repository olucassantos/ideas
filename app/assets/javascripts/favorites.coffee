class window.Favorite
  constructor: ->
    container = $('.presentation')
    favoriteButton = container.find('.favorite')

    $(favoriteButton).click (e) ->
      e.preventDefault()
      favorite = $(e.currentTarget)
      id = favorite.closest('.masterBox').data('id')

      $.ajax
        type: 'POST'
        url: "/favorite/#{id}/"
        success: (data) ->
          favorite.text(data.count)
        error: (err, data) ->
          console.log('ERRO DE FAVORITOS')