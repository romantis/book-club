'use strict';


require('uikit/dist/css/uikit.almost-flat.min.css');
require('./main.css');

const gm = require('google-maps');


// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);

app.ports.loadmap.subscribe(([latitude, longitude]) => {
    gm.load((google) => {
        let  options = {
            center: new google.maps.LatLng(latitude, longitude),
            zoom: 12,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        setTimeout(() => {
            let el = document.getElementById('place-map');
            if (!el) return console.log("Ooops. Element is not ready ", el)
            new google.maps.Map(el, options);
        }
        ,50)
    });
})
