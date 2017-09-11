(function(Elm){
    var containers = document.getElementsByClassName('container');
    containers = Array.prototype.slice.call(containers);
    containers.forEach(function(container){
        var app = Elm.Main.embed(container);
        app.ports.reset.send([3, 4, 5]);
    });
})(Elm);
