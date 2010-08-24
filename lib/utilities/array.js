Array.method('is_empty', function() {
	return (this.length < 1) ? true : false;
});

Array.method('each', function(callback) {
	for(i = 0; i < this.length; i++) {
		callback.call(this, this[i]);
	}
});

Array.method('contains', function(value) {
	for(i = 0; i < this.length; i++) {
		if(this[i] === value) {
			return true;
		}
	}
	return false;
});
