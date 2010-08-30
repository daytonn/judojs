if (exists === undefined) {
	var exists = function(variable) {	
		return (variable === undefined) ? false : true;
	};
}

if (!exists(doesNotExist)) {
	var doesNotExist = function(variable) {
		return (variable === undefined) ? true : false;
	};
}

if (doesNotExist(isTypeof)) {
	var isTypeof = function(type, variable) {
		try {
			if (doesNotExist(type)) {
				throw new SyntaxError("isTypeof(Type, variable): type is undefined");
			}
			if (doesNotExist(variable)) {
				throw new SyntaxError("isTypeof(Type, variable): variable is undefined");
			}

			return (variable.constructor == type) ? true : false;
		}
		catch(error) {
			document.write(error.message);
		}
	};
}

if (doesNotExist(isNumber)) {
	var isNumber = function(suspect) {
		if(isTypeof(Number, suspect)) {
			return true;
		}
		else {
			var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
			return pattern.test(suspect);	
		}
	};
}

if (doesNotExist(die)) {
	var die = function(last_words) {
		if(doesNotExist(last_words)) {
			lastwords = ''
		}
		document.write(lastwords)
	};
}
