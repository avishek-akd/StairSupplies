package com.stairsupplies.events {
	import flash.events.Event;

	public class ShipmentNewEvent extends Event
	{
		public static const SHIPMENT_NEW:String = "shipment_new";
		public var OrderID:int;
		
		public function ShipmentNewEvent(type:String, OrderID:int)
		{
			super(type, true);
			this.OrderID = OrderID;
		}
		
		
		override public function clone():Event {
			return new ShipmentNewEvent(type, OrderID);
		}
	}
}