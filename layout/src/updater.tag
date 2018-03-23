<updater class="progress" show={ is_updateAvailable }>
  <div class="indeterminate"></div>

  <style>
    updater {
      margin: auto !important;
    }
  </style>

  <script>
    var ipcRenderer = require('electron').ipcRenderer;

    ipcRenderer.on('check-update', function(args) {
      console.log(args);
    })
  </script>
</updater>
