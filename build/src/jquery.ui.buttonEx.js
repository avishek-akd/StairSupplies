/**
 * Override the default _create method so if the button has an icon we use that icon
 */
(function() {
	"use strict";


	var _savedCreate = $.ui.button.prototype._create;

	$.ui.button.prototype._create = function() {
		/*  fill in the options if we don't have */
		if( ! this.options.icon && this.element.data("icon") ) {
			this.options.icon = this.element.data("icon");
		}

		_savedCreate.call(this);
	}
})();