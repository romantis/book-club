'use strict';


require('uikit/dist/css/uikit.almost-flat.min.css');
require('./main.css');



// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);

app.ports.loadmap.subscribe(([latitude, longitude]) => {
    console.log("latitude: %s \n longitude: %s", latitude, longitude)    
})
