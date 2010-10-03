(function(){
  var app;
  app = {
    init: function() {
      return app.show_messages();
    },
    show_messages: function() {
      return $("#messages").slideDown('slow').fadeTo(3000, 1).slideUp('slow');
    }
  };
  $(document).ready(app.init);
})();
