package com.stairsupplies.events {
	import flash.events.Event;

	public class ShipmentClickedEvent extends Event
	{
		public static const SHIPMENT_CLICKED:String = "shipment_clicked";
		public var shipmentID:int;
		
		public function ShipmentClickedEvent(type:String, shipmentID:int)
		{
			super(type, true);
			this.shipmentID = shipmentID;
		}
		
		
		override public function clone():Event {
			return new ShipmentClickedEvent(type, shipmentID);
		}
	}
}