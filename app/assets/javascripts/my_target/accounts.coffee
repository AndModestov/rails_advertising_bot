ready = ->
  $('.new-account-link').click (e) ->
    $(this).hide()
    $('.account_form').show()

  $('.account_form').bind 'ajax:error', (e, data, status, xhr) ->
    errors = data.responseJSON
    $.each errors, (i, error) ->
      $('.account-errors').append("<li>#{error}</li>")

  $('.account_form').bind 'ajax:success', (e, data, status, xhr) ->
    $('.account_form').hide()
    $('.new-account-link').show()

  $ ->
    App.cable.subscriptions.create('AccountsChannel', {
      connected: ->
        @perform 'follow'
      ,
      received: (data) ->
        render_account(data)
    })

render_account = (data) ->
  if data.action == 'create'
    $(".accounts").append data.account
  else if data.action == 'update'
    $("#account-#{data.id}").replaceWith data.account
  else if data.action == 'delete'
    $("#account-#{data.id}").remove()


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
