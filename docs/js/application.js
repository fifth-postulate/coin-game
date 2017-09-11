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
    });

    function parseList(input){
        return input
            .trim()
            .split(/\s*,\s*/)
            .map(function(element){ return parseInt(element, 10); });
    }
})(Elm);
