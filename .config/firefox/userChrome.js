console.log('loading userChrome.js');

function reloadUserStyle() {

  // stylesheet service
  var sss = Components.classes["@mozilla.org/content/style-sheet-service;1"].
    getService(Components.interfaces.nsIStyleSheetService);

  // io service to access the file
  var ios = Components.classes["@mozilla.org/network/io-service;1"].
    getService(Components.interfaces.nsIIOService);

  // directory service to access the user chrome path ("UChrm")
  var chromePath = Components.classes["@mozilla.org/file/directory_service;1"].
    getService(Components.interfaces.nsIProperties).
    get("UChrm", Components.interfaces.nsIFile);

  //reload each files
  const files = ['/userChrome-noDef.css', '/userContent-noDef.css', '/scrollbar.as.css'];
  for ( let cssFile of files ) {

    console.log(cssFile);
    // build the path
    var userChromePath = 'file://' + chromePath.path + cssFile;

    // URI
    var uri = ios.newURI( userChromePath, null, null );

    // if registered unregister first
    while ( sss.sheetRegistered( uri, sss.USER_SHEET ) ) {
      sss.unregisterSheet( uri, sss.USER_SHEET );
    }

    // then load and register as USER_SHEET
    sss.loadAndRegisterSheet( uri, sss.USER_SHEET );

  }	
/*
  var scrollbarPath = 'file://' + chromePath.path + '/scrollbar.as.css'
  var uri = ios.newURI( scrollbarPath, null, null )
  // if registered unregister first
  while ( sss.sheetRegistered( uri, sss.AGENT_SHEEt ) ) {
    sss.unregisterSheet( uri, sss.AGENT_SHEET );
    console.log('unloaded scrollbar')
  }

  // then load and register as USER_SHEET
  sss.loadAndRegisterSheet( uri, sss.AGENT_SHEET );
  console.log('reloaded scrollbar')
  console.log(uri)
*/


  console.log('reloaded');
}

reloadUserStyle();

var chromePath = Components.classes["@mozilla.org/file/directory_service;1"].
		getService(Components.interfaces.nsIProperties).
		get("UChrm", Components.interfaces.nsIFile);

var lastModifChrome = 0;
var lastModifContent = 0;

async function needReload(){
  var userChrome = Components.classes['@mozilla.org/file/directory_service;1']
    .getService(Components.interfaces.nsIProperties)
    .get("UChrm", Components.interfaces.nsIFile);
  userChrome.append('userChrome-noDef.css');

  var userContent = Components.classes['@mozilla.org/file/directory_service;1']
    .getService(Components.interfaces.nsIProperties)
    .get("UChrm", Components.interfaces.nsIFile);
  userContent.append('userContent-noDef.css');

  var modifChrome = (await File.createFromNsIFile(userChrome)).lastModified;
  var modifContent = (await File.createFromNsIFile(userContent)).lastModified;

  var changed = modifChrome != lastModifChrome || modifContent != lastModifContent;

  lastModifChrome = modifChrome;
  lastModifContent = modifContent;

  return changed;
}

window.setInterval(async () => {
  var reload = await needReload();
  if (reload) {
    reloadUserStyle();
  }
}, 500)

//console.log("last modif: " + (await File.createFromNsIFile(userChrome)).lastModified);
