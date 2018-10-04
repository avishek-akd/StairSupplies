package com.stairsupplies.events {

	import com.stairsupplies.model.Product;
	import flash.events.Event;
	
	public class ProductSaveEvent extends Event {
		
		public var product:Product;
	
		public static const PRODUCT_SAVE_EVENT:String = "productSave";
		
		public function ProductSaveEvent(productValue:Product) {
			super("productSave", true, true);
			
			this.product = productValue;
		}
	
		override public function clone():Event {
			return new ProductSaveEvent(product);
		}
	}
}