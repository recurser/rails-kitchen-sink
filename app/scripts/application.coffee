app: {
  init: ->
    app.show_messages()
    app.hide_elements()
    
  show_messages: ->
    $("#messages").slideDown('slow').fadeTo(3000, 1).slideUp('slow');
  
  # Hack to hide the 'user' role checkbox - formtastic seems to ignore :collection after the form is posted.
  hide_elements: ->
    $("input#user_role_ids_2").parents('label').hide();
    
}

$(document).ready app.init