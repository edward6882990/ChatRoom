function MessagesDisplay (){
	this.$el  = $('#messages-display');

	// ================ Private Members =====================
	
	/* initialize the socket */
	var socket = io.connect('http://' + nodejs_ip);

	/* Socket IO handlers */	
	var printMessage = function (data) {
		$('<div/>').html(data.user_name + ': ' + data.message).appendTo(this.$el);
	};

	var onUserEntered = function (user_name){
		console.log('Socket IO: user entered');
		$('<div/>').html(user_name + ' has entered the room.').addClass('user-enter-notice').appendTo(this.$el);
	};

	var onUserLeft = function (user_name){
		console.log('Socket IO: user left');
		$('<div/>').html(user_name + ' has left the room.').addClass('user-left-notice').appendTo(this.$el);
	};

	/* Binding context to the handlers */
	var _printMessage  = $.proxy(printMessage, this);
	var _onUserEntered = $.proxy(onUserEntered, this);
	var _onUserLeft    = $.proxy(onUserLeft, this);

	//==========================================================
	
	/* Binding handlers Socket IO Events */
	socket.on('connect', function (){
		socket.emit('subscribe chatroom', { id: chat_id, user_name: user_name });
	});

	socket.on('user entered', function(data){
		_onUserEntered(data);
	});

	socket.on('user left', function(data){
		_onUserLeft(data);
	});

	socket.on('received message', function (data){
		_printMessage($.parseJSON(data));
	});

	socket.on('disconnect', function (){
		console.log('disconnect');
	});
}
