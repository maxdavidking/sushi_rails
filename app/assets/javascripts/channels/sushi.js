App.sushi = App.cable.subscriptions.create("SushiChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $('.alert-info').attr('class', 'alert alert-success');
    return $(".alert-success").html("File downloaded successfully " + data.sushi);
  }
});
