class window.Votes
  constructor: ->
    container = $('.presentation')
    voteButtons = container.find('.votes .vote')

    $(voteButtons).click (e) ->
      e.preventDefault()
      link = $(e.currentTarget)
      id = link.closest('.masterBox').data('id')
      vote = false
      vote = true if link.attr('id') == 'up'

      $.ajax
        type: 'POST'
        url: "/vote/#{id}/#{vote}"
        #data: {theory_id: id, vote: vote}
        success: (data) ->
          if data.status
             $('.vote#up').text(data.true)
             $('.vote#down').text(data.false)
        error: (err, data) ->
          console.log(vote)
          console.log('aconteceu algo estranho')

