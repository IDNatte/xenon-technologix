<main>
  <sidebar></sidebar>
  <navbar-component></navbar-component>
  <content></content>

  <firtRun-modaller>
    <div class="modal first-modal modal-fixed-footer">
      <div class="modal-content">
        <h5>REGISTER NUMBER</h5>
        <p>
          for first-run-user please insert register number that you've been obtained within application purchasement receipment
        </p>
        <form class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input id="input_text" type="text" placeholder="E.g 123-4567-789" data-length="12" maxlength="12" required>
              <label for="input_text">Insert Code</label>
            </div>
          </div>
        </form>

        <p>
          <label>
            <input type="checkbox" class="filled-in" />
            <span>With This I AGREE With Term and condition from Xenon Technologix agreement</span>
          </label>
        </p>

      </div>
      <div class="modal-footer">
        <a class="modal-close waves-effect waves-green btn-flat">register</a>
      </div>
    </div>

  </firstRun-modaller>

  <script>
    var ipcRenderer = require('electron').ipcRenderer;
    var firstRun = require('first-run');

    this.on('before-mount', function() {
      ipcRenderer.send('load-Storage', {status: "stgl-ready"});
    })

    this.on('mount', function() {
      if(firstRun() == true) {
        var frun = this.root.querySelector('.first-modal');
        $('input#input_text, textarea#textarea2').characterCounter();
        var modalInstances = M.Modal.init(frun, {dismissible: false});
        modalInstances.open();
      }

      ipcRenderer.send('load-Storage', {status: "mounted"});
    })
  </script>
</main>
