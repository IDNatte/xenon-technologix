<main>
  <sidebar></sidebar>
  <navbar-component></navbar-component>
  <content></content>

  <script>
    var ipcRenderer = require('electron').ipcRenderer;

    this.on('before-mount', function() {
      ipcRenderer.send('load-Storage', {status: "stgl-ready"});
    })

    this.on('mount', function() {
      ipcRenderer.send('load-Storage', {status: "mounted"});
    })
  </script>
</main>
