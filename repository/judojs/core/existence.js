if (isDefined === undefined) {
	var isDefined = function(variable) {	
		return (variable === undefined) ? false : true;
	};
}

if (!isDefined(isUndefined)) {
	var isUndefined = function(variable) {
		return (variable === undefined) ? true : false;
	};
}

if (isUndefined(isTypeof)) {
	var isTypeof = function(type, variable) {
		try {
			if (isUndefined(type)) {
				throw new SyntaxError("isTypeof(Type, variable): type is undefined");
			}
			if (isUndefined(variable)) {
				throw new SyntaxError("isTypeof(Type, variable): variable is undefined");
			}

			return (variable.constructor == type) ? true : false;
		}
		catch(error) {
			alert(error.message);
		}
	};
}

if (isUndefined(isNumber)) {
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
