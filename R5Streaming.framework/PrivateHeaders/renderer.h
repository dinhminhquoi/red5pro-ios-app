#ifndef _Included_renderer
#define _Included_renderer

#ifdef __cplusplus
extern "C" {
#endif

#include "connection_internal.h"

void on_draw_frame(client_ctx *client);
int init_gl(client_ctx*client);
void on_surface_created(client_ctx*client);
void on_surface_changed(client_ctx*client, int width, int height);

int get_surface_width(client_ctx*client);
int get_surface_height(client_ctx*client);

void start_rendering(client_ctx*client);
void stop_rendering(client_ctx*client);

    
#ifdef __cplusplus
}
#endif

#endif