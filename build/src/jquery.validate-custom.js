$(function($) {
	"use strict";


	function errorPlacement(errorElem, element) {
		var reference, $element = jQuery(element);
		var OFFSET_ERROR_MESSAGE = 10;  //  Distance between the closest parts of the element and the error message (it applies both to left and right side positions)
		var errorMessagePosition, arrowClass;


		/*
		 * Search for the element to which we need to anchor the error message in this order:
		 * - if this is a webeditor then the parent is the reference
		 * - if we have the "data-validationAttachTo" attribute then treat that as an ID
		 *     and attach the errror message to that element
		 * - if the element is not visible then consider the parent as the reference
		 * - if we have a checkbox try to find the label for the checkbox and attach to that
		 * - the element itself
		 */
		if ($element.attr("data-is-webeditor") == 1) {

				/*  Input is webeditor and is invisible so the error message is positioned based on the parent  */
				reference = element.parent();

		} else if( $element.data("validationAttachTo") ) {

				reference = jQuery($element.data("validationAttachTo"));

		} else if( ! $element.is(":visible") ) {

				reference = $element.parent();

		} else if( $element.attr("type") == "checkbox" ) {

				/*  The label must be attached to the current element  */
				var selectorLabelForCurrent = "*[for='" + $element.attr("id")  + "']";

				if( $element.nextAll(selectorLabelForCurrent).length == 1 ) {

					/*  We found a label after the element  */
					reference = $element.nextAll(selectorLabelForCurrent);

				} else if( $element.prevAll(selectorLabelForCurrent).length == 1 ){

					/*  Found a label before the element  */
					reference = $element.prevAll(selectorLabelForCurrent);

				} else {

					/*  No label found, take the checkbox and position the error relative to that  */
					reference = $element;

				}

		} else {

			/*  Normal element  */
			reference = element;

		}


		if(! reference.length) {
			throw new Error("Could not find the reference element");
		}


		//  Which side to display the error message
		if( (this.settings && this.settings.errorMessageSide === "right") || this.errorMessageSide === "right" ) {
			//  on the right side of the field ( <FIELD> <ERR_MSG>)
			errorMessagePosition = {
				my: "left+" + OFFSET_ERROR_MESSAGE + " center",
				at: "right center"
			}
			arrowClass = "field-error-message-arrow-left";
		} else {
			//  on the left side of the field ( <ERR_MSG> <FIELD>)
			errorMessagePosition = {
					my: "right-" + OFFSET_ERROR_MESSAGE + " center",
					at: "left center"
				}
			arrowClass = "field-error-message-arrow-right";
		}


		/*
		 *  	We need the reference element if the element is not currently visible because his position is not known.
		 *  When the element is visible again the error tooltip position is recalculated.
		 */
		errorElem.addClass("field-error-message")
			.prepend('<div class="' + arrowClass + '">&nbsp;</div>')
			.appendTo( reference.parent() )
			.data("errorReference", reference);

		/*  Position the error message after adding it to DOM  */
		$.extend(errorMessagePosition, {of: reference});
		$(errorElem).position( errorMessagePosition );
	}


	$.validator.addMethod("list_of_emails", function(value, element) {
		if( this.optional(element) )
			return true;

		var emails_valid = true;
		var saved_this = this;

		$(value.split(",")).each(function(index, item) {
			if( ! $.validator.methods['email'].call( saved_this, item.replace(/\r/g, ""), element ) ) {
				emails_valid = false;
			}
		})

		return emails_valid;
	}, "Please enter a list of emails separated by comma");


	/*
		Comma separated list of: numbers and full number ranges (1-10,2-3).
		For example: 1,2,3-5,10 . No partial ranges allowed (for example "-10" or "10-").
	*/
	$.validator.addMethod("postNumbersList", function(value, element) {
		var listOfNumbers = /^(\d+\-)?\d+(,(\d+\-)?\d+)*$/;

		return this.optional(element) || listOfNumbers.test(value);
	}, "Only numbers, comma and hyphen allowed.");


	/*  Number of posts must be equal to the quantity  */
	$.validator.addMethod("postNumbersCountEqualTo", function(value, element, ruleOptions) {
		function postNumberCount( postNumbersList ) {
			var p = postNumbersList.split(","),
				i = 0,
				result = 0;

			for(i=0; i < p.length; i++) {
				if( (p[i]+"").match(/\-/) ) {
					result = result + (+p[i].split("-")[1]) - (+p[i].split("-")[0]) + 1;
				} else {
					result++;
				}
			}

			return result;
		}

		var optionalValue = this.optional(element);

		if( optionalValue ) {
			return optionalValue;
		}

		var postCount = postNumberCount(value),
			quantity = +$(ruleOptions).val();

		if( postCount === quantity ) {
			return true;
		} else {
			$(element).rules("add", {
				messages: {
					postNumbersCountEqualTo: $.validator.format('The number of posts/handrails/glass panels ({0}) and Ordered quantity ({1}) must be equal.', postCount, quantity)
				}
			});

			return false;
		}
	}, "Default error message. If you see this please contact the administrator with information on the steps you were performing.");



	//  When a checkbox is checked make sure that other checkboxes are unchecked
	$.validator.addMethod("exclusiveCheck", function(value, element, ruleOptions) {
		var valid, checked;

		if( $(element).is(":checked") ) {
			checked = $(ruleOptions)
						.filter(function(index, element) {
							return $(element).is(":checked");
						})
			valid = (checked.length == 0);
		} else {
			/*  If we're unchecked then it's valid  */
			valid = true;
		}

		return valid;
	}, 'Other checkboxes must be unchecked !');


	/**
	* If the checkbox is not checked then return true.
	* If the checkbox is checked then at least one of the fields specified must be checked.
	*
	* @example $.validator.methods.ifCheckedAtLeastOne("1", element, "checkbox2:checked,checkbox3:checked")
	* @result true
	*
	*/
	$.validator.addMethod("ifCheckedAtLeastOne", function(value, elem, param) {

		return ! $(elem).is(":checked") || ( $(elem).is(":checked") && $(param).length != 0 );
	}, "You must select at least one !");


	/**
	* If the checkbox is not checked then return true.
	* If the checkbox is checked then at least one of the fields specified must be checked.
	*
	* @example $.validator.methods.requiredIfAllChecked("1", element, "checkbox2:checked,checkbox3:checked")
	* @result true
	*
	*/
	$.validator.addMethod("requiredIfAllChecked", function(value, elem, param) {
		return ! $(elem).is(":checked") || ( $(elem).is(":checked") && $(param).filter(":not(:checked)").length == 0 );
	}, "All items must be complete !");


	$.validator.setDefaults({
		errorPlacement: errorPlacement,
		errorMessageSide: "right",
		wrapper: 'label'
	});


	/*  Opt-in validation  */
	$("form.auto-validation").validate();
});