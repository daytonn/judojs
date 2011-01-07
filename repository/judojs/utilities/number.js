Number.method('to_hex', function() {
	if (this === 0) {
		return "00";
	}
	
	var chars = "0123456789ABCDEF";
	var n = Math.max(0, this);
	n = Math.min(n, 255);
	n = Math.round(n);
	return chars.charAt((n - n % 16)/16) + chars.charAt(n % 16);
});