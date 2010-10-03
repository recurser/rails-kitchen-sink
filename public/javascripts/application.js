(function(){
  var app;
  app = {
    init: function() {
      app.show_messages();
      return app.hide_elements();
    },
    show_messages: function() {
      return $("#messages").slideDown('slow').fadeTo(3000, 1).slideUp('slow');
    },
    hide_elements: function() {
      return $("input#user_role_ids_2").parents('label').hide();
    }
  };
  $(document).ready(app.init);
})();
