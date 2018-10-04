package com.stairsupplies.events {

	import flash.events.Event;
	
	public class ProductEditEvent extends Event {
		
		public var productId:int;
	
		public static const PRODUCT_EDIT_EVENT:String = "productEdit";
		
		public function ProductEditEvent(productId:int) {
			super("productEdit", true, true);
			
			this.productId = productId;
		}
	
		override public function clone():Event {
			return new ProductEditEvent(productId);
		}
	}
}