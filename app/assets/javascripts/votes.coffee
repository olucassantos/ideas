class window.Votes
  constructor: ->
    container = $('.headerBox')
    voteButtons = container.find('.votes a') 

    $(voteButtons).click (e) ->
      e.preventDefault()
      link = $(e.currentTarget)
      id = link.closest('.masterBox').data('id')
      vote = false
      vote = true if link.attr('class') == 'up'
        
      $.ajax
        type: 'POST'
        url: "/vote/#{id}/#{vote}"
        #data: {theory_id: id, vote: vote}
        success: (data) ->
          if data.status
            console.log('votei')
        error: (err, data) ->
          console.log(vote)
          console.log('aconteceu algo estranho')

