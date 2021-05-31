import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
const bibleGateWay = require("./Node/bibleGateway.js")

 
var app = Elm.Main.init({
  node: document.getElementById('root')
});

app.ports.getBibleGateway.subscribe(function(request){
  var BG = new bibleGateWay(request);

  BG.get().then(function(data){
    app.ports.recieveBibleGateway.send(BG.process(data))
  });

})


// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
