var CSS = function() {};

CSS.rgb2hex = function(r,g,b) {
	pattern = /(\d{1,3})\,\s?(\d{1,3})\,\s?(\d{1,3})/gi;
	var rgb;
	if (isTypeof(String, r)) {
		rgb = r.match(pattern);
		rgb = rgb[0].split(',');
	}
	else {
		rgb = false;
	}
	
	if (rgb) {
		r = parseInt(rgb[0], 10);
		g = parseInt(rgb[1], 10);
		b = parseInt(rgb[2], 10);
	}
	else {
		r = parseInt(r, 10);
		g = parseInt(g, 10);
		b = parseInt(b, 10);
	}
	return '#' + r.to_hex() + g.to_hex() + b.to_hex();
};

CSS.hex2rgb = function(hex) {
	hex = hex.replace('#', '');
	
	var rgb = [];
	
	rgb[0] = parseInt(hex.substring(0,2), 16);
	rgb[1] = parseInt(hex.substring(2,4), 16);
	rgb[2] = parseInt(hex.substring(4,6), 16);
	
	rgb.red = rgb[0];
	rgb.green = rgb[1];
	rgb.blue = rgb[2];
	
	rgb.to_s = function() {
		return 'rgb(' + rgb.red +', ' + rgb.green + ', ' + rgb.blue + ')';
	};
	
	rgb.each = function(callback) {
		for (var i = 0; i < 3; i++) {
			callback.call(this, rgb[i]);
		}
	}
	
	return rgb;
};