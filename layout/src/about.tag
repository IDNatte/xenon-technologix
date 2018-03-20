<about-component>
  <div class="row">
    <div class="col s6">

      <div class="card horizontal">
        <div class="card-image">
          <img src="images/side-about.png">
        </div>
        <div class="card-stacked">
          <div class="card-content">
            <span class="card-title">Xenon Archive</span>
            <p>
              <table class="striped responsive-table">
                <tbody>
                  <tr>
                    <td>Authors</td>
                    <td>Xenon Techx</td>
                  </tr>
                  <tr>
                    <td>Node Version</td>
                    <td>{ nodeVers }</td>
                  </tr>
                  <tr>
                    <td>Xenon Version</td>
                    <td>{ xenonVer }</td>
                  </tr>
                </tbody>
              </table>
            </p>
          </div>
          <div class="card-action">
            <a href="#"><i class="left material-icons">bug_report</i> Report Bug</a>
          </div>
        </div>
      </div>

    </div>
  </div>

  <script>
    var metavers = require('electron').remote.app.getVersion();

    this.xenonVer = metavers;
    this.nodeVers = process.versions.node;
  </script>
</about-component>