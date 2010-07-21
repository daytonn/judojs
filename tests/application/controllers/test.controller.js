// @include "lib/jquery-1.4.2.min.js"
// @include "lib/jquery-ui-1.8.2.min.js"

// @include "plugins/test.plugin.js"
// @include "plugins/jquery.fancybox-1.3.1.js"

// @include "application/views/test.view.js"
// @include "application/models/test.model.js"

$(document).ready(function() {
	JudoApp.test_id.click(function() {
		alert('this is a dummy function');
		alert(JudoApp.test_model.some_data_member);
	});
});