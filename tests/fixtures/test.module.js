MyApplication.addModule('TestModule');

//= require "../elements/test.elements.js"
//= require "../models/test.model.js"

MyApplication.TestModule.actions = function() {
  console.log(MyApplication.TestModule.test_id.html());
};

$(document).ready(function(){
  MyApplication.TestModule.run();
});
