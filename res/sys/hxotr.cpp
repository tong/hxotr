
#define IMPLEMENT_API
#define NEKO_COMPATIBLE

#include <hx/CFFI.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>

extern "C" {
#include "proto.h"
#include "privkey.h"
#include "message.h"
//#include "context.h"
#include "instag.h"
}

DEFINE_KIND( k_otr_userstate );
DEFINE_KIND( k_otr_version_pointer );

#define val_userstate(o) (OtrlUserState)val_data(o)


static value hxotr_init() {
	printf( "hxotr_init\n" );
	OTRL_INIT;
	return val_null;
}
DEFINE_PRIM( hxotr_init, 0 );

static value hxotr_version() {
	return alloc_string(  otrl_version() );
}
DEFINE_PRIM( hxotr_version, 0 );

static value hxotr_userstate_create() {
	printf( "hxotr_userstate_create\n" );
	OtrlUserState s = otrl_userstate_create();
	return alloc_abstract( k_otr_userstate, s );
}
DEFINE_PRIM( hxotr_userstate_create, 0 );

static value hxotr_userstate_free( value s ) {
	printf( "hxotr_userstate_free\n" );
	otrl_userstate_free( val_userstate(s) );
	return val_null;
}
DEFINE_PRIM( hxotr_userstate_free, 1 );

static value hxotr_privkey_read( value s, value path ) {
	printf( "hxotr_privkey_read\n" );
	otrl_privkey_read( val_userstate(s), val_string(path) );
	return val_null;
}
DEFINE_PRIM( hxotr_privkey_read, 2 );

//TODO otrl_instag_read(userstate, instagfilename);
//TODO otrl_privkey_read_fingerprints(userstate, fingerprintfilename, add_app_info, add_app_info_data);


/*
void* receive_msgs( void* data ) {
}

const char* otr_error_message( void *opdata, ConnContext *context, OtrlErrorCode err_code ) {
	char* result;
	//TODO
	return result;
}
*/

void parse_outgoing_msg_otr( uint32_t id, uint32_t *size, unsigned char** buf_ptr ) {
}

static value hxotr_send( value payload ) {
	int sent = -1;
	/*
	//send_msg_otr( id, size, payload );
	parse_outgoing_msg_otr( id, &size, (unsigned char**) payload );
	if( !size || !*payload )
		return alloc_int( sent );
	//sent = send_msg(size, *payload);
	*/
	return alloc_int( sent );
}
DEFINE_PRIM( hxotr_send, 2 );

static value hxotr_recv() {
}