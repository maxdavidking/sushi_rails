App.sushi = App.cable.subscriptions.create("SushiChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if (data.filename == "Download failed") {
      $(".alert-info").attr("class", "alert alert-danger");
      return $(".alert-danger").html(data.filename + "<a href='/sushi" + data.sushipath + "/edit'> edit your connection information </a>");
    }
    else {
      $(".alert-info").attr("class", "alert alert-success");
      return $(".alert-success").html(data.filename + " downloaded successfully <a href='" + data.filepath +"'> download here </a>");
    }
  }
});
