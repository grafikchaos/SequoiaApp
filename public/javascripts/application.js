/**
 * Document ready stuff. All pageload functionality
 * happens here.
 */
$(document).ready(function() {
  initCollapsibles();
  clientPageSearch();
  bookmarksMenuDropDown();
  initQtips();
  initProjectSelector();
});

/**
 * Handle collapsible fieldsets.
 */
var initCollapsibles = function() {
  $('fieldset.collapsible').each(function() {
    $('legend', this).click(function() {
      $(this).siblings().slideToggle();
      if ($(this).parent().hasClass('collapsed')) {
        $(this).parent().removeClass('collapsed');
      } else {
        $(this).parent().addClass('collapsed');
      }
    });
  });
};


/**
 * Generic AJAX form submission handler.
 */
var handleAjaxFormSubmit = function(form, callback) {
  form.submit(function() {
    var url = form.attr('action');
    $.ajax({
      type: 'POST',
      url: url,
      data: form.serialize(),
      success: function(data) {
        callback(data);
        clearForm(form);
      }
    });
    return false;
  });
};

/**
 * Clear form data.
 */
var clearForm = function(element) {
  $(element).find(':input').each(function() {
    switch(this.type) {
      case 'password':
      case 'select-multiple':
      case 'select-one':
      case 'text':
      case 'textarea':
        $(this).val('');
        break;
      case 'checkbox':
      case 'radio':
        this.checked = false;
        break;
    }
  });
};


/**
 * Generic data reload handler.
 */
var reloadData = function(element, message) {
  
  // Default message.
  var message = message ? message : 'Loading';
  startLoading(element, message);
  
  switch (element) {
    // Add elements here.
  }
  
};

/**
 * Generic loading message.
 */
var startLoading = function(selector, message) {
  
  // Default message.
  var message = message ? message : 'Loading';
  
  var html  = '<img src="/images/ajax-loader.gif" /> '
            + message + '&hellip;';
            
  $(selector).html(html);
};

/**
 * Notices.
 */
var postNotice = function(content, type) {
  
  var type = type ? type : 'notice';
  
  var html  = '<div class="flash-message '+type+'">'
            + content
            + '</div>';
        
  $('body').append(html);
  $('.flash-message').fadeIn('slow', function() {
    $(this).delay(1500).fadeOut('slow', function() {
      $(this).remove();
    });
  });
};

/**
 * Client page search form.
 */
var clientPageSearch = function() {
  $('#client-search input#search')
    .focus()
	.keyup(function() {
    if ($(this).val().length > 1) {
      $.get($('#client-search').attr('action'), $('#client-search').serialize(), function(data) {
        $('#client-list').replaceWith($('#client-list', data));
      });
    }
  });

};

/**
 * Bookmarks menu.
 */
var bookmarksMenuDropDown = function() {
  $('#bookmarks-link a').qtip({
    content: 'Loading...',
    show: 'click',
    hide: 'unfocus',
	  position: {
      corner: {
        target: 'bottomMiddle',
        tooltip: 'topMiddle'
      }
    },
    style: {
      tip: 'topMiddle', 
      name: 'dark',
      border: {
        radius: 3
      }
    },
    api: {
      onRender: function() 
      {
        var self = this
        $.get('/user/bookmarks', function(data) {
          self.updateContent($('.bookmarks-list', data));
        });          
      }
    }
  });
};

/**
 * Submitting the project selector form on change
 */
var initProjectSelector = function() {
  $('form#proj_selector select#project').change(function() {
    $('form#proj_selector').submit();
  });
};

var initQtips = function() {
	$('.tooltip').qtip({
	  show: 'mouseover',
	  hide: 'mouseout',
	  position: {
      corner: {
        target: 'topMiddle',
        tooltip: 'bottomMiddle'
      }
    },
    style: {
      tip: 'bottomMiddle', 
      name: 'dark',
      border: {
        radius: 3
      }
    }
	});
};
