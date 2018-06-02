<archive-list>

  <div  class="row">
    
    <div class="col s12">

      <ul class="collapsible">
        <li each={ data }>
          <div class="collapsible-header">
            <i class="material-icons">insert_drive_file</i>
            { archiveSub }
          </div>
          <div class="collapsible-body">

            <div>
              <span>Recipment : </span>
              <recipment each={ value, name  in recipient }>
                { value }
              </recipment>
            </div>

            <div>
              <span>Document Date : { documentDate }</span>
            </div>

            <div>
              <span>Accepted Date : { acceptedDate }</span>
            </div>

            <div>
              <span>Document Number : { docNumber }</span>
            </div>

            <div>
              <span>Issued Number : { issuedDocNumber }</span>
            </div>

            <div>
              <span>Archive Descirption : { archiveSub }</span>
            </div>

            <div class="footer">
              <a class="waves-effect waves-red btn-flat" href="#print-doc">Print</a>
              <a class="waves-effect waves-red btn-flat" onclick={ openPDFfile.bind(this, archiveAttachment.path) }>See Attachment file</a>
            </div>

          </div>
        </li>
      </ul>

    </div>
  </div>


  <script>

    var ipcRenderer = require('electron').ipcRenderer;

    this.on('mount', function() {
      var d = ipcRenderer.sendSync('get-data');
      this.update({data : d});
      
      $('.collapsible').collapsible();
    })



    sharedObservable.on('search-res', function(args) {
      this.update({data: args.result});
    }.bind(this))

    openPDFfile(args) {
      var file = args
      ipcRenderer.send('open-pdf', file);
    }

  </script>
</archive-list>