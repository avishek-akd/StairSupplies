package com.stairsupplies.model {

	[Bindable]
	[RemoteClass(alias="ironbaluster.com.stairsupplies.ProductSearch")]
	public class ProductSearch {

		public var CompanyID:Number = 0;
		public var productionTypeID:Array = [];
		public var materialID:Array = [];
		public var vendorID:Array = [];
		public var keyword:String = "";
		public var product_id:Number = 0;
		public var WebsitePartName:String = "";
		public var archived:Boolean = false;


		public function ProductSearch() {
		}

	}
}