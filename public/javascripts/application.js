/**
 * Document ready stuff. All pageload functionality
 * happens here.
 */
$(document).ready(function() {
  initCollapsibles();
  initFlashHide();
  initSearch();
  initBookmarksMenu();
  initQtips();
  initProjectSelector();
  initRemoveRows();
  initToggleMasked();
  initEntityTypeFormReloader();
  initSortableLists();
  initHotKeys();
  initFavableLinks();
  initJumpLinks();
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
 * Hide flash messages after a specified time.
 */
var initFlashHide = function() {
  if ($('#flash-messages').length > 0) {
    $('#flash-messages').delay(2000).slideUp();
  }
}

/**
 * Client page search form.
 */
var initSearch = function() {
  if ($('#main-search input#query').val() == '') {
    $('#main-search input#query').focus();
  } else {
    $('#results-list .row:first-child').addClass('selected');
  }
};

/**
 * Bookmarks menu.
 */
var initBookmarksMenu = function() {
  $('a#bookmarks-menu')
  .live('ajax:beforeSend', function() {
    $(this).qtip({
      content: {
        prerender: true,
        text: '<img src="/images/ajax-loader.gif" />'
      },
      show: {
        when: false,      
      },
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
      }
    });
    $(this).qtip('api').show();
  })
  .live('ajax:success', function(evt, data, status, xhr) {
    $(this).qtip('api').updateContent(data);
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

/**
 * Toggles removal of an entity row.
 */
var initRemoveRows = function() {
  $('.remove a').click(function() {
    if ($(this).parent().parent().hasClass('will-remove')) {
      $(this).siblings('input[type=hidden]').val(0);
      $(this).parent().parent().removeClass('will-remove');
      $(this).parent().siblings('div.field').show();
      $(this).parent().siblings('div.delete-message').hide();
    } else {
      $(this).siblings('input[type=hidden]').val(1);
      $(this).parent().parent().addClass('will-remove');
      $(this).parent().siblings('div.field').hide();
      $(this).parent().siblings('div.delete-message').show();
    }
    $(this).hide();
    $(this).siblings('.toggle').show();
  });
}

/**
 * Toggles value field for masked entity rows.
 */
var initToggleMasked = function() {
  $('.entity-row .show-plaintext').live('click', function() {
    $(this).siblings('span.value').toggle();
    var text = $(this).text() == 'Show value' ? 'Hide value' : 'Show value';
    $(this).text(text);
  });
}

/**
 * Reloads the entity rows form when a new entity type is selected.
 */
var initEntityTypeFormReloader = function() {
  $('select#entity_entity_type_id').change(function() {
    var type = $(this).val();
    $.ajax({
      url: '',
      data: {
        'entity_type_id' : type,
      },
      type: 'get',
      success: function(data) {
        $('#entity_rows_form').replaceWith($('#entity_rows_form', data));
      }
    });
  });
};

/**
 * UI Sortable lists.
 */
var initSortableLists = function() {
  $('.sortable').sortable({
    items: '> div',
    handle: 'div.sort-handle',
    placeholder: 'ui-sortable-placeholder',
    axis: 'y',
    stop: function(event, ui) {
      $('> div', this).each(function(index, element) {
        $('input.sort-order', element).val(index);
        console.log(index, element);
      });
    }
  });
}

/**
 * For adding fields to our entity edit page.
 */
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

/**
 * Tooltips.
 */
var initQtips = function() {
  $('.tooltip').each(function() {
    // You can either use the 'data-tooltip' attribute or the title.
    var tipContent = $(this).attr('data-tooltip') ? $(this).attr('data-tooltip') : $(this).attr('title');
    $(this).qtip({
      content: $(this).attr('data-tooltip'),
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
  });
};

/**
 * Hotkeys.
 */
var initHotKeys = function() {
  $(document)
  .bind('keyup', 's', function() {
    $('input#query').focus();
  })
  .bind('keydown', 'k', function() {
    if ($('#results-list div.row.selected').length == 0) {
      $('#results-list div.row:last-child').addClass('selected');
    } else {
      $('#results-list .row.selected').removeClass('selected').prev('div.row').addClass('selected');
    }
  })
  .bind('keydown', 'j', function() {
    if ($('#results-list div.row.selected').length == 0) {
      $('#results-list .row:first-child').addClass('selected');
    } else {
      $('#results-list .row.selected').removeClass('selected').next('div.row').addClass('selected');
    }
  })
  .bind('keyup', 'l', function() {
    if ($('#results-list .row.selected .data a.client').length > 0) {
      window.location = $('#results-list .row.selected .data a.client').attr('href');
    }
  })
  .bind('keyup', 'n', function() {
    if ($('a#new-client').length > 0) {
      window.location = $('a#new-client').attr('href');
    }
  })
  .bind('keyup', 'h', function() {
    $.colorbox({
      href: '/static/hotkey-help.html'
    });
  });
};

var initFavableLinks = function() {
  $('a.favorite-link')
  .live('ajax:beforeSend', function(evt, xhr, settings) {
    $(this).replaceWith('<img class="loader" src="/images/ajax-loader.gif" />');
  })
  .live('ajax:success', function(evt, data, status, xhr) {
    $('img.loader').replaceWith(data);
  });
};

var initJumpLinks = function() {
  $('.jump-menu .jump-hover').mouseenter(function() {
    $(this).siblings('.links').fadeIn();
  });
  $('.jump-menu').mouseleave(function() {
    $('.links', this).fadeOut();
  });
}
