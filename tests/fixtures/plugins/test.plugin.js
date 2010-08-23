(function($) {
    $.fn.testplugin = function(options) {
        var defaults = {};
        var options = $.extend(defaults, options);

        return this.each(function() {
          console.log(this);
        });
        // End $(this).each()
    };
})(jQuery);
