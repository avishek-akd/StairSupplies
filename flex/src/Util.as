import mx.collections.ArrayCollection;
import mx.messaging.messages.ErrorMessage;
import mx.rpc.events.FaultEvent;
import mx.utils.ObjectProxy;


/**
 *  Convert an array of items to a bindable array of items that can be used as a bind source
 */
public function convertToBindable( array:ArrayCollection ):ArrayCollection {
	for(var i:int=0; i < array.length; i++) {
		array[i] = new ObjectProxy( array[i] );
	}
	
	return array;
}


public function addErrorFields(products:ArrayCollection):ArrayCollection {
	
	products.source.forEach(function(item:*, index:int, arr:Array):void {
		item.errorStringQuantity = '';
		item.errorStringBoxSkid  = '';
	});
	
	return convertToBindable( products );
}


public function verifyAndRedirectIfSessionExpired(event:FaultEvent):void {
	/*  TODO: FIXME: hardcoded path to login   */
	if( mx.messaging.messages.ErrorMessage(event.message).faultString.indexOf("session has expired") != -1 ) {
		navigateToURL(new URLRequest('/ironbaluster/login/login.cfm'), '_self');
		return;
	}
}
