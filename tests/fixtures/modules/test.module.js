// @module TestModule
// @include "plugins/test.plugin.js"

// @include "elements/test.elements.js"
// @include "models/test.model.js"

$(document).ready(function() {
	JudoApp.test_id.click(function() {
		alert('this is a dummy function');
		alert(JudoApp.test_model.some_data_member);
	});
});
