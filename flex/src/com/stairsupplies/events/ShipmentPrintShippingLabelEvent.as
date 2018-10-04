package com.stairsupplies.events {
	import flash.events.Event;

	public class ShipmentPrintShippingLabelEvent extends Event
	{
		public static const SHIPMENT_PRINT_SHIPPING_LABEL:String = "shipment_print_shipping_label";
		public var orderID:int;
		
		public function ShipmentPrintShippingLabelEvent(type:String, orderID:int)
		{
			super(type, true);
			this.orderID = orderID;
		}
		
		
		override public function clone():Event {
			return new ShipmentPrintShippingLabelEvent(type, orderID);
		}
	}
}