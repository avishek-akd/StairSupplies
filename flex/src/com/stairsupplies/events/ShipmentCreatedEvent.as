package com.stairsupplies.events {
	
	import flash.events.Event;

	public class ShipmentCreatedEvent extends Event
	{
		public static const SHIPMENT_CREATED:String = "shipment_created";
		public var OrderID:int;
		
		public function ShipmentCreatedEvent(type:String, OrderID:int)
		{
			super(type, true);
			this.OrderID = OrderID;
		}
		
		
		override public function clone():Event {
			return new ShipmentCreatedEvent(type, OrderID);
		}
	}
}