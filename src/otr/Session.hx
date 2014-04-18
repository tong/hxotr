package otr;

private typedef OTR = Dynamic; //TODO

@:require(js)
class Session {
	
	static function __init__() {
		#if embed_js
		haxe.macro.Compiler.includeFile("../res/js/dep/salsa20.js");
		haxe.macro.Compiler.includeFile("../res/js/dep/bigint.js");
		haxe.macro.Compiler.includeFile("../res/js/dep/crypto.js");
		haxe.macro.Compiler.includeFile("../res/js/dep/eventemitter.js");
		haxe.macro.Compiler.includeFile("../res/js/dsa-webworker.js");
		haxe.macro.Compiler.includeFile("../res/js/sm-webworker.js");
		#if debug
		haxe.macro.Compiler.includeFile("../res/js/otr.js");
		#else
		haxe.macro.Compiler.includeFile("../res/js/otr.min.js");
		#end
		#end
	}

	public dynamic function onUI( msg : String ) {}
	public dynamic function onIO( msg : String ) {}
	public dynamic function onError( msg : String ) {}
	public dynamic function onStatus( msg : Int ) {}

	public var crypto(default,null) : OTR;

	public function new( ?key : Dynamic, fragment_size : Int = 140, send_interval : Int = 200 ) {
		var opts = {
			fragment_size: fragment_size,
			send_interval: send_interval,
			priv : key
		};
		crypto = untyped __js__('new OTR(this.opts)');
		crypto.on( 'ui', ui );
		crypto.on( 'io', io );
		crypto.on( 'error', handleError );
		crypto.on( 'status', handleStatus );
	}

	public function sendQuery() {
		crypto.sendQueryMsg();
	}

	public function recv( msg : String ) {
		crypto.receiveMsg( msg );
	}

	public function send( msg : String ) {
		crypto.sendMsg( msg );
	}

	public function end() {
		crypto.endOtr();
	}

	function ui(s) {
		onUI(s);
	}

	function io(s) {
		onIO(s);
	}

	function handleError(s) {
		onError(s);
	}

	function handleStatus(s) {
		onStatus(s);
	}
}
