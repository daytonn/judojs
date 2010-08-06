// @module TestModule
// @include "plugins/test.plugin.js"

// @include "elements/test.elements.js"
// @include "models/test.model.js"

JudoApp.TestModule.actions = function() {
  console.log(JudoApp.TestModule.test_id.html());
};

$(document).ready(function(){
  JudoApp.TestModule.run();
});
