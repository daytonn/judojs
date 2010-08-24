//= require "existence"

if (doesNotExist(Object.prototype['method'])) {
	Object.prototype.method = function(name, func) {
		try {
			if (doesNotExist(name)) {
				throw "You must give a name to the method";
			}
			if (doesNotExist(func)) {
				throw "You must define a function for the method";
			}

			if (doesNotExist(this.prototype[name])) {
				this.prototype[name] = func;
				return this;
			}
		}
		catch(error) {
			alert(error);
		}
	};
}