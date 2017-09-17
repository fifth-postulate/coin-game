(function(Elm){
    var containers = document.getElementsByClassName('container');
    containers = Array.prototype.slice.call(containers);
    containers.forEach(function(container){
        var app = Elm.Main.embed(container);
        var position = container.dataset.position;
        if (position) {
            position = parseList(position);
            app.ports.reset.send(position);
        }
        var gameType = container.dataset.type;
        if (gameType) {
            app.ports.changeType.send(gameType);
        }
    });

    function parseList(input){
        return input
            .trim()
            .split(/\s*,\s*/)
            .map(function(element){ return parseInt(element, 10); });
    }
})(Elm);
