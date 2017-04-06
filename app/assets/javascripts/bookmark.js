$(document).on('ready', function(){

  setTimeout(function(){
    $('.save').on('click', function(){
      var currentConfig = myMiradorInstance.saveController.currentConfig;
      var workspaceUpdateUrl = $('#viewer').data('workspace-update-url');

      var updateData = {
        "workspace": {
          "data": JSON.stringify(currentConfig)
        }
      };

      $.ajax({
        url: workspaceUpdateUrl,
        type: "PUT",
        data: updateData,
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      });

    });
  }, 1000);

});
