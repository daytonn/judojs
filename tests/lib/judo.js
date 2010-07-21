// (original makeClass - By John Resig (MIT Licensed))
function JudoClass() {
	return function(args) {
		if(!(this instanceof arguments.callee)) {
			return new arguments.callee(arguments);
		}
		else {
			if(typeof this.init == "function") {
				this.init.apply(this, args.callee ? args : arguments);
			}
		}
	};
}

Judo = new JudoClass();

Judo.prototype.init = function() {
	this.version = '0.1.0';
	this.v = this.version;
};