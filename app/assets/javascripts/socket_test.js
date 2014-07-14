/**
 * Created by Haseeb on 7/15/2014.
 */

// only using for test purpose
// modularity can be achieved using angular js

$(function () {
    var Socket = window.MozWebSocket || window.WebSocket,
        socket = new Socket('ws://' + 'localhost' + ':' + '7000' ),
        index  = 0;

    socket.onopen = function() {
        console.log("connected!");
        data = {command: "authenticate", token:"here we must send the token"};

        socket.send(JSON.stringify(data))

        // used to keep the socket alive
        setInterval(function(){
            socket.send(JSON.stringify({
                command: 'ping'
            }));
        }, 10000);

    };

    socket.onerror = function(event) {
        console.log('ERROR: ' + event.message);
    };

    socket.onmessage = function(event) {
        console.log('MESSAGE: ' + event.data);
    };

    socket.onclose = function(event) {
        console.log('CLOSE: ' + event.code + ', ' + event.reason);
    };
});

