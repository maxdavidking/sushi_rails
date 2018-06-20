// app/assets/javascripts/channels/datum.js

App.datum = App.cable.subscriptions.create('SushiChannel', {
  received: function(data){
    console.log("First step complete");
    return $(".alert-info").append(this.renderMessage(data));
  },

  renderMessage: function(data){
    console.log("Second step complete");
    return "<p> <b>" + data + "</b> </p>";
  }
});
