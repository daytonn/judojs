(function($) {
    
    $.fn.recipetoolbar = function(options) {
        var defaults = {
            status: $('#loading'),
            errorDialog: $('#errors-dialog'),
            errorMessages: $('#error-messages'),
            confirmDialog: $('#confirm-dialog'),
            confirmMessage: $('#confirm-message')
        };

        var options = $.extend(defaults, options);

        return this.each(function() {
            var toolbar = $(this);
            var recipe_id = toolbar.attr('rel');
            var add_to_favorites = toolbar.find('a.add-to-favorites');
            var remove_favorites = toolbar.find('a.remove-favorite');
            var add_to_trylist = toolbar.find('a.add-to-trylist');
            var remove_trylist = toolbar.find('a.remove-from-trylist');
                        
            add_to_favorites.bind('click', function(e) {
               e.preventDefault();
               var add_link = $(this);
                $.ajax({
                    url: add_link.attr('href'),
                    dataType: 'json',
                    beforeSend: function(response) {
                        options.status.text('Attempting to add to favorites');
                        options.status.slideDown();
                    },
                    success: function(response) {
                        if(response.success) {
                            options.status.text('Added to favorites');
                            options.status.slideUp();
                            add_link.replaceWith('<span class="added">Added to favorites</span>');
                        }
                        else {
                            options.status.text('Action failed');
                            options.status.slideUp();
                            options.errorMessages.empty();
                            $(response.errors).each(function(i) {
                                options.errorMessages.append('<p>'+response.errors[i]+'</p>');
                            });
                            options.errorMessages.show();
                            options.errorDialog.dialog('option', 'title', 'Add to favorites error');
                            options.errorDialog.dialog('open');
                            return false;
                        }
                    }
                });
                // End of $.ajax
            });
            // End add_to_favorites.click()
            
            remove_favorites.bind('click', function(e) {
                e.preventDefault();
                var recipe_id = $(this).attr('rel');
                var remove_link = $(this);
                options.confirmMessage.text('Are you sure you want to remove this recipe from your favorites?')
                options.confirmDialog.dialog({
                    bgiframe: true,
                    resizable: false,
                    modal: true,
                    overlay: {
                        backgroundColor: '#000',
                        opacity: 0.5
                        },
                    buttons: {
                        'Remove': function() {
                            $.ajax({
                                url: remove_link.attr('href'),
                                dataType: 'json',
                                beforeSend: function(response) {
                                    options.status.text('Attempting to remove from favorites');
                                    options.status.slideDown();
                                },
                                success: function(response) {
                                    if(response.success) {
                                        options.status.text('Removed from favorites');
                                        options.status.slideUp();
                                        remove_link.replaceWith('<span class="added">Removed from favorites</span>');
                                        options.confirmDialog.dialog('close');
                                        $('#recipe-'+recipe_id).hide();
                                    }
                                    else {
                                        options.confirmDialog.dialog('close');
                                        options.status.text('Action failed');
                                        options.status.slideUp();
                                        options.errorMessages.empty();
                                        $(response.errors).each(function(i) {
                                            options.errorMessages.append('<p>'+response.errors[i]+'</p>');
                                        });
                                        options.errorMessages.show();
                                        options.errorDialog.dialog('option', 'title', 'Remove from favorites error');
                                        options.errorDialog.dialog('open');
                                        return false;
                                    }
                                }
                            });
                            // End of $.ajax
                        },
                        Cancel: function() {
                            $(this).dialog('close');
                        }
                    }
                });
                
            });
            // End remove_favorites.click()
            
            add_to_trylist.bind('click', function(e) {
               e.preventDefault();
               var trylist_link = $(this);
                $.ajax({
                    url: trylist_link.attr('href'),
                    dataType: 'json',
                    beforeSend: function(response) {
                        options.status.text('Attempting to add to try list');
                        options.status.slideDown();
                    },
                    success: function(response) {
                        if(response.success) {
                            options.status.text('Added to try list');
                            options.status.slideUp();
                            trylist_link.replaceWith('<span class="added">Added to trylist</span>');
                            console.log(response);
                        }
                        else {
                            options.status.text('Action failed');
                            options.status.slideUp();
                            options.errorMessages.empty();
                            $(response.errors).each(function(i) {
                                options.errorMessages.append('<p>'+response.errors[i]+'</p>');
                            });
                            options.errorMessages.show();
                            options.errorDialog.dialog('option', 'title', 'Add to trylist error');
                            options.errorDialog.dialog('open');
                            return false;
                        }
                    }
                });
                // End of $.ajax
            });
            // End add_to_trylist.click()
            
            remove_trylist.bind('click', function(e) {
                e.preventDefault();
                var recipe_id = $(this).attr('rel');
                var remove_link = $(this);
                options.confirmMessage.text('Are you sure you want to remove this recipe from your try list?')
                options.confirmDialog.dialog({
                    bgiframe: true,
                    resizable: false,
                    modal: true,
                    overlay: {
                        backgroundColor: '#000',
                        opacity: 0.5
                        },
                    buttons: {
                        'Remove': function() {
                            $.ajax({
                                url: remove_link.attr('href'),
                                dataType: 'json',
                                beforeSend: function(response) {
                                    options.status.text('Attempting to remove from try list');
                                    options.status.slideDown();
                                },
                                success: function(response) {
                                    if(response.success) {
                                        options.status.text('Removed from try list');
                                        options.status.slideUp();
                                        remove_link.replaceWith('<span class="added">Removed from try list</span>');
                                        options.confirmDialog.dialog('close');
                                        $('#recipe-'+recipe_id).hide();
                                    }
                                    else {
                                        options.confirmDialog.dialog('close');
                                        options.status.text('Action failed');
                                        options.status.slideUp();
                                        options.errorMessages.empty();
                                        $(response.errors).each(function(i) {
                                            options.errorMessages.append('<p>'+response.errors[i]+'</p>');
                                        });
                                        options.errorMessages.show();
                                        options.errorDialog.dialog('option', 'title', 'Remove from try list error');
                                        options.errorDialog.dialog('open');
                                        return false;
                                    }
                                }
                            });
                            // End of $.ajax
                        },
                        Cancel: function() {
                            $(this).dialog('close');
                        }
                    }
                });
            });
            // End remove_favorites.click()
        });
        // End $(this).each()
    };
})(jQuery);