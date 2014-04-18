
#if nodejs
import js.Node;
#else
import js.Browser.document;
import js.Browser.window;
#end
import otr.Session;

class App {

	static function append( msg : String ) {
		#if nodejs
		Node.console.log( msg );
		#else
		var p = document.createDivElement();
		p.innerHTML = msg;
		document.body.appendChild( p );
		#end
	}

	static inline function now() : Float return Date.now().getTime();

	static function ui( msg ) { trace( msg ); }
	static function err( msg ) { trace( msg ); }

	static function init() {

		var start = now();

		var userA = new Session( {} );
		var userB : Session = null;

		userA.onUI = ui;
		userA.onIO = function(msg) {
			userB.recv( msg );
		};
		userA.onError = err;

		append('OTR object generated (' + (now() - start) + 'ms)');

		userB = new Session();
		userB.onUI = ui;
		userB.onIO = userA.recv;
		userB.onError = err;

		userA.sendQuery();
		userA.onStatus = function(state){
			if( state == untyped OTR.CONST.STATUS_AKE_SUCCESS ) {
				append( 'ake took <strong>' + (now() - start) + 'ms</strong>');
				append( 'message state is ' + (userA.crypto.msgstate ? 'encrypted' : 'plaintext') + '</strong>');
			}
		}
	}

	static function main() {
		trace( "hxotr" );
		#if nodejs
		init();
		#elseif js
		window.onload = function(_) { init(); }
		#end
	}
}
