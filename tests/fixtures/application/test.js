// File generated Wed Aug 04 01:01:59 -0500 2010 by judo

(function($){$.fn.testplugin=function(options){var defaults={};var options=$.extend(defaults,options);return this.each(function(){});};})(jQuery);

$(document).ready(function(){JudoApp.test_id=$('#test-element-with-id');console.log(JudoApp.test_id);});

JudoApp.test_model={some_data_member:'some data value'};

$(document).ready(function(){JudoApp.test_id.click(function(){alert('this is a dummy function');alert(JudoApp.test_model.some_data_member);});});