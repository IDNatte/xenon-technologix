const { dialog, ipcMain, app, BrowserWindow } = require('electron');
const { autoUpdater } = require('electron-updater');
const pdfWindow = require('electron-pdf-window');

// const isDev = require('electron-is-dev');

const exfs = require("fs-extra");
const loki = require("lokijs");
const path = require('path');
const url = require('url');
const os = require('os');

let entryPoint = path.join(os.homedir(), 'Documents/xenon/datastore/') ;
let col
let win
let db

function createWindow () {
  win = new BrowserWindow({
    width: 1280,
    height: 680,
    minHeight: 768,
    minWidth: 1024
  })

  win.loadURL(url.format({
    pathname: path.join(__dirname, 'layout/index.html'),
    protocol: 'file:',
    slashes: true
  }))

  exfs.ensureDirSync(entryPoint);
  exfs.ensureDirSync(path.join(entryPoint, 'attachment/'));
  
  win.on('closed', () => {
    win = null
  })


  autoUpdater.checkForUpdatesAndNotify()
}


function openPDF(path) {
  const pmw = new pdfWindow({
    parent: win,
    modal: true,
    alwaysOnTop: true
  })

  pmw.loadURL(path);
}

app.on('ready', () => {
  createWindow();

  // elemon live reload for development mode
  // if (isDev) {
  //   const elemon = require('elemon');
  //   elemon({
  //     app: app,
  //     mainFile: 'main.js',
  //     bws: [
  //       {
  //         bw: win,
  //         res: ['index.html', 'extra.css', 'main.js']
  //       }
  //     ]
  //   })    
  // }
})
  
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

ipcMain.on('load-Storage', (event, args) => {

  let mountStat = args.status;

  if (mountStat === "stgl-ready") {
    let cdbFile = path.join(entryPoint, 'archive.json');
    exfs.ensureFile(cdbFile).then(() => {
      db = new loki(cdbFile);
  
      db.loadDatabase({}, () => {
        _col = db.getCollection('archiveCollection');
        if (_col) {
          col = _col;
        }else {
          col = db.addCollection('archiveCollection');
        }
      });
  
    })
  }
})

ipcMain.on('get-data', (event) => {
  event.returnValue = col.data
})

ipcMain.on('open-pdf', function(e, args) {
  let path = args
  openPDF(path);
})

ipcMain.on('search-data', (event, args) => {
  let r = col.find({
    '$or':[
      {
        'documentDate': {
          '$containsAny': args.query
        }
      },
      {
        'archiveSub': {
          '$containsAny': args.query
        }
      },
      {
        'recipient': {
          '$containsAny': args.query
        }
      },
      {
        'acceptedDate': {
          '$containsAny': args.query
        }
      },
      {
        'issuedDocNumber': {
          '$containsAny': args.query
        }
      }
    ]
  });

  event.returnValue = r
})

ipcMain.on('save-Data', (event, args) => {

  let saveThis = JSON.parse(args);
  let time = new Date()
  let currentTime = `${time.getHours()}-${time.getMinutes()}-${time.getSeconds()}`
  let copyMe = saveThis.archiveAttachment.path;
  let renameFormat = `${saveThis.documentDate} ${currentTime}`;

  let copyPathAttachmentFileName = path.join(entryPoint, `attachment/${renameFormat}.pdf`);

  exfs.copy(copyMe, copyPathAttachmentFileName).then(() => {

    let saveDBDataWrapper = {
      archiveAttachment: {
        path : copyPathAttachmentFileName,
        type: saveThis.archiveAttachment.type
      },
      documentDate: saveThis.documentDate,
      docNumber: saveThis.docNumber,
      sendedDate: saveThis.sendedDate,
      archiveSub: saveThis.archiveSub,
      recipient: saveThis.recipient,
      issuedDocNumber: saveThis.issuedDocNumber

    };

    if (db && col) {
      col.insert(saveDBDataWrapper);
      db.saveDatabase(() => {
        let initData = col.data;
        event.sender.send('sd-Replay', {status : 'done'});
        event.sender.send('data-send', initData);
      })
    }else {
      event.sender.send('sd-Replay', {status : 'error'});
    }
  })
})

app.on('activate', () => {
  if (win === null) {
    createWindow()
  }
})