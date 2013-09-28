class window.Favorite
  constructor: ->
    container = $('.headerBox')
    favoriteButton = container.find('.favorite a') 

    $(favoriteButton).click (e) ->
      e.preventDefault()
      favorite = $(e.currentTarget)
      id = favorite.closest('.masterBox').data('id')
        
      $.ajax
        type: 'POST'
        url: "/favorite/#{id}/"
        success: (data) ->
          if data.status
            console.log('favoritei')
        error: (err, data) ->
          console.log('aconteceu algo estranho')