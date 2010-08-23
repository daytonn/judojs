(function($) {
    $.fn.testplugin = function(options) {
        var defaults = {};
        var options = $.extend(defaults, options);

        return this.each(function() {
          console.log(this);
        });
    };
})(jQuery);

$(document).ready(function() {
	JudoApp.TestModule.test_id = $('#test-element-with-id');
	console.log(JudoApp.TestModule.test_id);
});
JudoApp.test_model = {
	some_data_member: 'some data value'
};

JudoApp.TestModule.actions = function() {
  console.log(JudoApp.TestModule.test_id.html());
};

$(document).ready(function(){
  JudoApp.TestModule.run();
});
