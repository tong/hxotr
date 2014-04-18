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
	public dynamic function onStatus( msg : Dynamic ) {} //TODO

	public var crypto(default,null) : OTR;

	public function new( ?opts : Dynamic ) {
		//TODO
		var opts = { fragment_size: 140, send_interval: 200, priv: null };
		crypto = untyped __js__('new OTR(opts)');
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


/*
enum OTRState {
	initialized;
	ready;
}

@:keep
@:expose
class Session {
	
	#if js

	public dynamic function onReady() {}
	public dynamic function onEncrpyted( t : String ) {}
	public dynamic function onDecrypted( t : String ) {}

	public var state(default,null) : OTRState;
	public var occupant(default,null) : String;

	var stream : jabber.Stream;
	var crypt : Dynamic;
	var i : Int;

	/*
	public function new( stream : jabber.Stream, occupant : String ) {
		this.stream = stream;
		this.occupant = occupant;
		state = null;
	}
	* /

	public function new( occupant : String ) {
		this.occupant = occupant;
	}

	public function init() {

		/*
		var key : Dynamic = null;
		var storageId = "otr_"+Account.active.jid+"_"+session.contact.jid;
		var _key = LocalStorage.getItem( storageId );
		if( _key == null ) {
			trace( "generating new key ..." );
			var k : Dynamic = null;
			untyped __js__('k=new DSA();');
			key = k;
			LocalStorage.setItem( storageId, JSON.stringify( key ) );
		} else {
			key = JSON.parse( _key );
		}
		* /
		var key : Dynamic = null;
		var k : Dynamic = null;
		untyped __js__('k=new DSA();');
		key = k;
		
		state = initialized;
		i = 0;

		var opts = { fragment_size: 140, send_interval: 200, priv: key }
		//buddy = new OTR(options);
		var ui = this.ui;
		var io = this.io;
		crypt = untyped __js__('new OTR(opts);');
		crypt.on('ui',ui);
		crypt.on('io',io);
		crypt.on('error', function(e){trace(e);} );
		crypt.sendQueryMsg();
		trace(">>>>>>");
	}

	public function enrypt( t : String ) {
		//trace("send ("+otr.msgstate+")");
		crypt.sendMsg( t );
	}

	public function decrypt( t : String ) {
		//if( otr 
		//trace("recieve ("+otr.msgstate+")");
		crypt.receiveMsg( t );
	}

	public function end() {
		//TODO
	}

	function io( t : String ) {
		trace( "io("+state+")("+(i++)+")("+(crypt.msgstate ? 'encrypted' : 'plaintext')+")"  );
		if( crypt.msgstate && state == initialized ) {
			//state = ready;
			//onReady();
		}
		if( i == 6 ) { //TODO ??? WTF
			trace("READYREADYREADYREADYREADYREADYREADYREADYREADYREADY");
			state = ready;
			onReady();
		}
		switch( state ) {
		case initialized:
			sendXMPPMessage( t );
	//	case ready:
			//trace("RRREADY!!");
		default:
		}
		//onDecrypted( t );
		//otr.receiveMsg( t );
	}

	function ui( t : String ) {
		trace( "ui("+state+")" );
		//trace( t );
		onDecrypted( t );
	}

	function sendXMPPMessage( t : String ) {
		var m = new xmpp.Message();
		m.body = t;
		m.from = stream.jid.toString();
		m.to = occupant;
		stream.sendData( m.toString() );
	}

	#elseif sys

	var userState : Dynamic;

	public function new() {
	}

	public function init() {
		userState = _userstate_create();
	}

	public function end() {
		_userstate_free( userState );
	}

	public function encrypt( data : String ) {
	}

	public function decrypt() {
	}

	private static var _userstate_create = lib( 'userstate_create' );
	private static var _userstate_free = lib( 'userstate_free' );
	private static var _privkey_read = lib( 'privkey_read', 2 );

	public static inline function lib( f : String, n : Int = 0 ) : Dynamic {
		#if cpp
		return cpp.Lib.load( 'otr', 'hxotr_$f', n );
		#elseif neko
		return neko.Lib.load( 'otr', 'hxotr_$f', n );
		#end
	}

	#end

}
*/
