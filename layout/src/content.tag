<content>
  <router>
    <route path=""><archive-list></archive-list></route>
    <route path="new-archive"><create-archive></create-archive></route>
    <route path="about"><about-component></about-component></route>
  </router>

  <script>

    var ipcRenderer = require('electron').ipcRenderer;

    this.on('before-mount', function() {
      ipcRenderer.send('load-Storage', {status: "stgl-ready"});
    })

  </script>
</content>