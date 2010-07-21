if(window['console'] === undefined) {
	window.console = {
		log: function(message) {
			// Do nothing -DN
		}
	};
}

function isTypeof(type, variable) {
	try {
		if (arguments.length < 2) {
			throw "you must provide 2 arguments: isTypeof(variable, type)";
		}
	}
	catch(error) {
		handleError(error);
	}

	if (variable === null && type === null) {
		return true;
	} else if (variable === undefined && type === undefined) {
		return true;
	} else if (variable.constructor == type) {
		return true;
	} else {
		return false;
	}
}

function exists(variable) {
	var exists = true;

	if (variable === undefined) {
		exists = false;
	} else if (variable === null) {
		exists = false;
	}

	return exists;
}



function notEmpty(array) {
	return (array.length > 0) ? true : false;
}



function isEmpty(array) {
	return (array.length < 1) ? true : false;
}



function handleError(options) {
	var settings = {
		error: false,
		mode: 'strict'
	};

	for (var setting in options) {
		settings[setting] = options[setting];
	}

	if (!settings.error) {
		alert('handleError(): error is undefined');
	}

	if (settings.mode === 'log') {
		console.log(settings.error);
	} else if (settings.mode === 'strict') {
		alert(setting.error);
	}
}



function fails(func) {
	try {
		func.call(this);
		return false;
	}
	catch(error) {
		return true;
	}
}
