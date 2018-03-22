var electronInstaller = require('electron-winstaller');

resultPromise = electronInstaller.createWindowsInstaller({
  appDirectory: './resources/app/packed/Technologix-win32-x64/',
  outputDirectory: './dist/',
  authors: 'Xenon Technologix',
  owners: 'IDNatte',
  certificateFile: './build/xenon.pfx',
  certificatePassword: 'xenon-technologix',
  iconUrl: 'https://raw.githubusercontent.com/IDNatte/xenon-technologix/master/build/icon.png',
});

resultPromise.then(() => console.log("It worked!"), (e) => console.log(`No dice: ${e.message}`));