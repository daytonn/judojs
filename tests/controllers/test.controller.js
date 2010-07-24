// @include "plugins/test.plugin.js"

// @include "elements/test.elements.js"
// @include "models/test.model.js"

$(document).ready(function() {
	TestApp.test_id.click(function() {
		alert('this is a dummy function');
		alert(TestApp.test_model.some_data_member);
	});
});
