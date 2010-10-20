//= require "existence"

if (doesNotExist(Function.prototype['method'])) {
	Function.prototype.method = function(name, func) {
		try {
			if (doesNotExist(name)) {
				throw new SyntaxError("Object.method(name, func): name is undefined");
			}
			if (doesNotExist(func)) {
				throw new SyntaxError("Object.method(name, func): func is undefined");
			}

			if (doesNotExist(this.prototype[name])) {
				this.prototype[name] = func;
				return this;
			}
		}
		catch(error) {
			alert(error.message);
		}
	};
}