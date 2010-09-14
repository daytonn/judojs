//= require "existence"

if (doesNotExist(Object.prototype['method'])) {
	Object.prototype.method = function(name, func) {
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
			document.write(error.message);
		}
	};
}

if (doesNotExist(Object.prototype['clone'])) {
	Object.method('clone', function() {
		if (typeof this !== 'object' || this === null) {
			return this;
		}
		
        if (this instanceof Node || this instanceof NodeList || this instanceof NamedNodeMap) {
            die('You cannot clone a Node, Nodelist or NamedNodeMap');
        }
		
		var clone = isTypeof(Array, this) ? [] : {};
		
		for(var prop in this) {
			if(this.hasOwnProperty(prop)) {
				clone[prop] = this[prop];
			}
		}
		
		return clone;
	});
}