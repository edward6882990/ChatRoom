/*********************************************************
 * Object: InputControl
 * Description: Javascript for the Input Control Elements 
 *********************************************************/
function InputControl (){
	this.$el         = $('#input-control');
	this.$text_field = this.$el.find('#text-input');
	this.$send_btn   = this.$el.find('#input-send');

	this.initialize = function (){
		this.bindEvents();
	};

	this.bindEvents = function (){
		this.$text_field.keypress($.proxy(_onTextFieldKeyPress, this));
		this.$send_btn.click($.proxy(_onSendBtnClick, this));

		/* Socket IO Handlers */
	};

	// ================= Private Members =====================
	
	/* Handler for Pressing 'Enter' when text field is focus */
	var _onTextFieldKeyPress = function (event){
		if (event.which == 13) _sendMessage();	
	};

	var _onSendBtnClick = function (event){
		_sendMessage();
	};
		
	var sendMessage = function (){
		/* return if it is an empty message */
		if (this.$text_field.val() == '') return;

		$.ajax({
			url     : '/messages',
			type    : 'POST',
			context : this,
			data    : {
				message: {
					chat_id : chat_id,
					user_id : user_id,
					content : this.$text_field.val()
				}
			},
			beforeSend: function (){
				// TODO: Show spinner for sending message 
			},
			success: function () {
				// Clear the text field if message was sent successfully
				this.$text_field.val('');
			},
			error: function (res, status){
				// TODO: Error handling for sending a message
				// - Display an error message
			},
			complete: function (){
				// TODO: Hide spinner after ajax is done
			}
		});
	};

	var _sendMessage = $.proxy(sendMessage, this);
	// =======================================================

	/* initialize */
	this.initialize();
}
