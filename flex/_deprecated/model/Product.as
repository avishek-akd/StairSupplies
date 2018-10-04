package com.stairsupplies.model {
	import mx.collections.ArrayCollection;
	
	
	[Bindable]
	[RemoteClass(alias="ironbaluster.com.stairsupplies.model.Product")]
	public class Product {
		public var ProductID:Number;

		public var CompanyID:Number;
		public var Vendor_ID:Number;
		public var ProductType_id:Number;
		public var ProductName:String;
		public var ProductDescription:String;
		public var Production_Instructions:String;
		public var Customer_Notes:String;
		public var UnitPrice:Number;
		public var UnitPriceViewrail:Number;
		public var VR_Part:String;
		public var UnitPriceNAC:Number;
		public var Purchase_Price:Number;
		public var Unit_of_Measure:String;
		public var UnitWeight:Number;
		public var MaterialID:Number;
		public var MaterialSizeID:Number;
		public var BoardFootage:Number;
		public var LaborCost:Number;
		public var PreFinishCost:Number;
		public var StairMargin:Number;
		public var FinishPrice:Number;
		public var DefaultFinishOptionID:Number;
		public var WebsitePartName:String;
		public var WebsiteURL:String;
		public var WebsiteImageURL:String;
		public var CutLength:Number;
		public var CutAngle:Number;
		public var PostTopStyleID:Number;
		public var PostFootStyleID:Number;
		public var Configuration:String;
		public var HurcoProgram:String;
		
		public var archived:Boolean;
		
		public var IncludedProducts:Array = new Array();
		public var Autosuggestions:Array = new Array();

		public var BoardFootage_history:String;
	}
}