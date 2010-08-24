if (exists === undefined) {
	function exists(variable) {	
		return (variable === undefined) ? false : true;
	}	
}

if (!exists(doesNotExist)) {
	function doesNotExist(variable) {
		return exists(variable) ? false : true;
	}
}

if (doesNotExist(isTypeOf)) {
	function isTypeof(type, variable) {
		try {
			if (doesNotExist(type)) {
				throw "type is undefined";
			}
			if (doesNotExist(variable)) {
				throw "variable is undefined";
			}

			return (variable.constructor == type) ? true : false;
		}
		catch(error) {
			alert(error);
		}
	}
}

if (doesNotExist(isNumber)) {
	function isNumber(number) {
		var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
		return pattern.test(number);
	}
}
