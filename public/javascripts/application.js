/**
 * Adding a case-insensitive :contains selector
 */
jQuery.expr[':'].icontains = function(a,i,m){
  return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
};

/**
 * Document ready stuff. All pageload functionality
 * happens here.
 */
$(document).ready(function() {
  initCollapsibles();
  initSearch();
  initMessageCloseButton();
  initProjectSelector();
  initRemoveRows();
  initToggleMasked();
  initEntityTypeFormReloader();
  initSortableLists();
  initHotKeys();
  initFavableLinks();
  initFavoriteMenuListener();
  initFavFilter();
  initJumpLinks();
  initEntityControlLinks();
  initPassGen();
});

/**
 * Handle collapsible fieldsets.
 */
var initCollapsibles = function() {
  $('fieldset.collapsed .fieldset-wrapper').hide();
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
 * Close button for flash messages.
 */
var initMessageCloseButton = function() {
  if ($('.flash').length > 0) {
    $('.flash .message a.close').click(function() {
      $(this).parent().parent('.message').fadeOut();
    });
  }
};

/**
 * Submitting the project selector form on change
 */
var initProjectSelector = function() {
  $('form#proj_selector select#project').selectmenu({
    width: 200,
    change: function() {
      $('form#proj_selector').submit();
    },
    format: function(str) {
      str = '<span class="name">' + str;
      str = str.replace('|', '</span><span class="domain">');
      str += '</span>';
      return str;
    }
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
  $('.entity-row a.show-plaintext')
  .live('ajax:beforeSend', function(evt, xhr, settings) {
    var val_field = $(this).siblings('.value')[0];
    if ($(val_field).hasClass('shown')) {
      var d_length = $(val_field).text().length;
      var asterisks = '';
      for (i = 1; i < d_length; i++) {
        asterisks += '*';
      }
      $(val_field).text(asterisks);
      $(val_field).removeClass('shown').addClass('masked');
      $(this).text('Show');
      // Stop the AJAX request.
      return false;
    }
  })  
  .live('ajax:success', function(evt, data, status, xhr) {
    var parsed = $.parseJSON(data);
    var val_field = $(this).siblings('.value')[0];
    if ($(val_field).hasClass('masked')) {
      $(val_field).text(parsed.value);
      $(val_field).removeClass('masked').addClass('shown');
      $(this).text('Hide');
      // Create an audit too.
      addAudit('EntityRow', $(this).data('id'), 'Sensitive information for Entity "'+parsed.entity.entity.name+'" under client "%client" accessed by %user');
    }
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

var initFavoriteMenuListener = function() {
  $('a.favorite-link').live('ajax:success', function() {
    $.get('/favorites', function(data) {
      $('#sidebar .favorites ul').html(data);
    });
  });
};

var initFavFilter = function() {
  $('.favorites input#fav-filter').bind('keyup', function() {
    var string = $(this).val();

    $(this).siblings('ul').children('li').each(function() {
      $('*:not(:icontains("'+string+'"))', this).hide();
      $('*:icontains("'+string+'")', this).show();
    });
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

var initEntityControlLinks = function() {
  $('.entity .controls ul').hide();
  $('.entity .controls a.control-link').click(function() {
    $(this).siblings('ul').toggle();
  });
};

var initPassGen = function() {
  $('a#passgen-link').click(function() {
    $.colorbox({
      href: '/static/passgen.html'
    });
  });
}

function addAudit(modelType, modelID, message) {
  var audit = {
    model_type: modelType,
    model_id: modelID,
    message: message
  }

  $.ajax({
    url: '/admin/audits',
    data: { audit: audit },
    type: 'POST',
  });
}
