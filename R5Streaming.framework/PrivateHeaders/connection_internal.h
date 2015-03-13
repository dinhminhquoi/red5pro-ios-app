//
//  connection.h
//  red5streaming
//
//  Created by Andy Zupko on 10/27/14.
//  Copyright (c) 2014 Andy Zupko. All rights reserved.
//

#ifndef __red5streaming__connection__
#define __red5streaming__connection__

#ifdef __cplusplus
extern "C" {
#endif
    
#include "global.h"
#include "uv.h"
#include "rpc.h"
    
#include <string.h>
#include <stdlib.h>

#include "connection_internal.h"
#include "session_description.h"
#include "codec_facade.h"
    
#ifndef __APPLE__
#   define AL_LIBTYPE_STATIC
#   include <AL/al.h>
#   include <AL/alc.h>
#else
#   include <OpenAL/al.h>
#   include <OpenAL/alc.h>
#endif
    

#include "libavcodec/avcodec.h"
#include "libavutil/imgutils.h"
#include "libswscale/swscale.h"
#include "libswresample/swresample.h"


#define BUFFER_SIZE 4096
#define MAX_QUEUE_SIZE 200

#define WAIT_DELAY 0

#define CONTAINER_OF(ptr, type, field)                                        \
((type *) ((char *) (ptr) - ((char *) &((type *) 0)->field)))
    
    

enum client_state {
    
    s_req_connect=0,
    s_conn_complete,
    s_req_options,
    s_read_options,
    s_parse_options,
    s_req_describe,
    s_read_describe,
    s_parse_describe,
    s_req_announce,
    s_read_announce,
    s_req_setup,
    s_read_setup,
    s_cont_setup,
    s_req_play,
    s_read_play,
    s_req_record,
    s_read_record,
    s_stream_start,
    s_streaming,
    s_dequeue,
    s_kill,
    s_dead
};


typedef struct client_ctx client_ctx;

typedef int (*conn_cb_t)();
typedef void (*idle_cb_t)(client_ctx*ctx, int status);
typedef void (*next_cb_t)(client_ctx*ctx);

enum conn_state {
    c_busy,  /* Busy; waiting for incoming data or for a write to complete. */
    c_done,  /* Done; read incoming data or write finished. */
    c_stop,  /* Stopped. */
    c_dead
};
    
    enum event_type{
        e_stream,
        e_config,
        e_rpc
    };
    


typedef struct payload{
    
    char buf[BUFFER_SIZE];
    int size;
    int type;
    int is_key;
    double queue_time_ms;
    struct payload *next;
    
} payload;

typedef struct payload_queue{
    struct payload *head;
    struct payload *tail;
    int size;
    int dropping_payload;
    
} payload_queue;
    
    
typedef struct rtp_frame {
    uint8_t type;
    int marker;
    uint16_t sequence;
    uint32_t timestamp;
    uint32_t ssrc;
    const char* payload;
    int length;
    struct rtp_frame* next;
} rtp_frame;
    
typedef struct rtp_frame_queue{
    struct rtp_frame *head;
    struct rtp_frame *tail;
    int size;
    
} rtp_frame_queue;
    
typedef struct r5_event{
    client_ctx* client;
    enum event_type type;
    int code;
    const char  *msg;
    const void *custom;
}r5_event;

typedef void (*config_cb_t)(int status, client_ctx *client, const char*msg);
typedef void (*rpc_cb_t)(client_ctx *client, rpc_call *rpc);
    

    
    typedef struct stream_config{
        
        int protocol;
        char host[256];
        char applicationName[256];
        char contextName[256];
        char streamName[256];
        int port;
        char sdp_body[1024];
        char setup[10][256];
        int setup_count;
        
        //in seconds
        float buffer_time;
        
        
    }stream_config;


//defined in stream.h
typedef struct stream_ctx stream_ctx;
typedef struct r5_stats r5_stats;

    
    typedef struct r5_private_data{
        
        double last_received_timestamp;
        double bytes_received_since_timestamp;
        
        double last_sent_timestamp;
        double bytes_sent_since_timestamp;
        
        
        
        
    }r5_private_data;
    
typedef struct client_ctx{
    
    unsigned int state;   /* state of the client in the process */
    unsigned int rdstate; /* conn read state */
    unsigned int wrstate; /* conn write state */
    uv_write_t write_req; /* write request handle */
    unsigned int idle_timeout;
    uv_idle_t idler;
    uv_loop_t *loop;
    
    struct sockaddr_in *addr;
    
    uv_sem_t read_sem;
    uv_thread_t read_thread;
    
    struct{
        
        rpc_cb_t rpc_cb;
        config_cb_t configuration_callback;
        next_cb_t donext_callback;
        uv_read_cb read_cb;
        idle_cb_t idle_cb;
        //uv_async_t thread_cb;

        
    } callback;
    
    union {
        uv_handle_t handle;
        uv_tcp_t tcp;
        uv_pipe_t pipe;
        uv_stream_t stream;
    } handle;
    
    struct {
        int setup_step;
        int total_steps;
    } progress;
    
    ssize_t result;
    
    union{
        uv_connect_t connect_req;
        uv_shutdown_t shutdown_req;
        char buf[BUFFER_SIZE];
    } t;
    
    struct{
        int g_width;
        int g_height;
        int g_started;
        int g_first_call;
        int had_texture;
        int texture_updated;
    }gl;
    
    struct{
        struct payload_queue *publish;
        struct rtp_frame_queue *subscribe;
        struct payload *current_packet;
    }queue;
    
    struct r5_private_data private_data;
    
    
    struct stream_config configuration;
    
    uv_timer_t              timer_handle;  /* For detecting timeouts. */
    uv_timer_t              timer_send_handle;  /* For publish sending */
    uv_timer_t              audio_mixer_timer; /*for audio mixing */
    uv_timer_t              video_mixer_timer; /* for updating current frame */
    
    uv_mutex_t mutex;
    const char *error_message;
    void* stream_controller;
    session_description *sdp;

    r5_stream_mode_t mode;
	media_decoder_t *decoder;
    
    stream_ctx *streamer;
    int display_initialized;
    int audio_initialized;
    
    struct r5_stats stats;
    
} client_ctx_t;

void queue_packet(client_ctx *client, payload *packet);
void queue_frame(client_ctx *client, rtp_frame *frame);

int dequeue_packet(client_ctx *c);
rtp_frame *get_next_frame(client_ctx*c);

void start_client(client_ctx *c);
void stop_client(client_ctx *c);

int do_kill(client_ctx *c);
void conn_read(client_ctx *c);
void conn_write(client_ctx *c, const void *data, unsigned int len);
void release_client(client_ctx* c);
void get_uri_header( char * head_type,  char* head, client_ctx* client);
void dispatch_event(client_ctx*client, enum event_type type, int status, const char*msg, const void *data);
void dispatch_rpc(client_ctx*client, rpc_call*rpc);
void thread_callback(uv_async_t *handle, int status);
    
char* r5_get_debug_info(client_ctx *client);
    
client_ctx *r5_alloc_client();

    
#ifdef __cplusplus
}
#endif
#endif /* defined(__red5streaming__connection__) */
