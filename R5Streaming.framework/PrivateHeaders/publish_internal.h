#include "uv.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "connection_internal.h"

#ifndef _Included_com_red5pro_streaming_R5Publish
#define _Included_com_red5pro_streaming_R5Publish
#ifdef __cplusplus
extern "C" {
#endif
    
/* Die with fatal error. */
#define FATAL(msg)                                        \
do {                                                    \
fprintf(stderr,                                       \
"Fatal error in %s on line %d: %s\n",         \
__FILE__,                                     \
__LINE__,                                     \
msg);                                         \
fflush(stderr);                                       \
abort();                                              \
} while (0)
    


void start_publish(client_ctx *client);
void stop_publish(client_ctx *client);

void do_next(client_ctx *client);

void send_rpc(client_ctx *client, void *buffer, int length);
void send_conn_call(client_ctx *client, void *buffer, int length);
    
#ifdef __cplusplus
}
#endif
#endif