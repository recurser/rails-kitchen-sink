app: {
  init: ->
    app.show_messages()
    
  show_messages: ->
    $("#messages").slideDown('slow').fadeTo(3000, 1).slideUp('slow');
    
}

$(document).ready app.init