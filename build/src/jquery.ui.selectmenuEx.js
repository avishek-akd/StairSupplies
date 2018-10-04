"use strict";

/*
	2 changes over the base selectmenu:
	- the label for the trigger button is taken from the label attribute of SELECT instead of being the label of the first item
	- add support for icons in the items
*/
$.widget("ui.selectmenuEx", $.extend({}, $.ui.selectmenu.prototype, {

	_init: function() {
		this.element.data('selectmenu', this.element.data('selectmenuEx'));

		return $.ui.selectmenu.prototype._init.apply(this, arguments);
	},

	/*  Change compared to base: The trigger button should have a static label.  */
	_renderButtonItem: function(item) {
		var buttonItem = $( "<span>" );

		/*  BEGIN: change */
		this._setText( buttonItem, this.element.attr("label") );
		/*  END: change  */
		this._addClass( buttonItem, "ui-selectmenu-text" );

		return buttonItem;
	},

	/*  Change compared to base: Add support for item icons  */
	_renderItem: function( ul, item ) {
		var li = $( "<li>" ),
			wrapper = $( "<div>", {
				title: item.element.attr( "title" )
			} );

		if ( item.disabled ) {
			this._addClass( li, null, "ui-state-disabled" );
		}
		/*  BEGIN: add  */
		$( "<span>", {
				style: item.element.attr( "data-style" ),
				"class": "ui-icon " + item.element.attr( "data-icon" )
			})
		/*  END: add */
		this._setText( wrapper, item.label );

		return li.append( wrapper ).appendTo( ul );
	}
}));


$.ui.selectmenuEx.defaults = $.extend({}, $.ui.selectmenu.defaults);