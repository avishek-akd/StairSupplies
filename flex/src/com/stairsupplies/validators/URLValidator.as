package com.stairsupplies.validators
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public class URLValidator extends Validator
	{
		public function URLValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array
		{
			// Clear results Array.
			var results:Array = [];
			
			// Call base class doValidation().
			results = super.doValidation(value);        
			// Return if there are errors.
			if (results.length > 0)
				return results;
			
			// match regex pattern
			var pattern:RegExp = new RegExp("^http[s]?\:\\/\\/([^\\/]+)");
			// run the pattern, but don't error if there is no value and this is not required
			if (!(!required && !value) && !pattern.exec(String(value))) {
				results.push(new ValidationResult(true, null, "notURL", 
					"You must enter a valid URL."));
				return results;
			}
			
			return results;
		}
	}
}