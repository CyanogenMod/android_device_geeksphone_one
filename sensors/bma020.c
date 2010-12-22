/* RC, 2010
 *
 * Ok, so /dev/bma020 in the original ROM is read 6 bytes at a time...
 * Wild guess: those 6 bytes are the XYZ coordinates accel values...
 */


// This will kill the logs! Use with extreme caution :)
//#define LOG_NDEBUG 0
//
#define LOG_TAG "Sensors"
//#define PRINT_VALUES 1

#include <cutils/log.h>

#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <poll.h>

#include <math.h>

#include <sys/ioctl.h>
#include <sys/types.h>

#include <hardware/sensors.h>

#define BMA_DEVICE "/dev/bma020"

int64_t requested_delay = 0;
int got_wake = 0;
int bma020fd = -1;

int data_open(struct sensors_data_device_t *dev, native_handle_t* nh) {
    LOGV("data_open");
    bma020fd = dup(nh->data[0]);
    /*native_handle_close(nh);
      native_handle_delete(nh);*/
    return 0;
}

int data_close(struct sensors_data_device_t *dev) {
    LOGV("data_close");
    if (bma020fd > 0) {
        close(bma020fd);
        bma020fd = -1;
    }
    return 0;
}

int calc_orientation=0;

#ifdef PRINT_VALUES
int temp_loop = 0;
int temp_aloop = 0; 
#endif

int data_poll(struct sensors_poll_device_t *dev, struct sensors_event_t* data, int count) {
    LOGV("data_poll");
    //
    while (!got_wake) {
		sleep(1);
    }
	if (bma020fd < 0) {
	int fd = open(BMA_DEVICE, O_RDONLY);
	if(fd < 0)
		return 0;
	bma020fd = fd;
	}

    struct  {
        short x, y, z;
    } acceldata;

    struct pollfd fds;
    int nr;
    static float gravity = GRAVITY_EARTH / 256.0f;

    LOGV("data_poll begin");
    fds.fd = bma020fd;
    fds.events = POLLIN;
    fds.revents = 0;
    nr = poll(&fds, 1, 1000);
    if(nr > 0 && fds.revents & POLLIN) {
        read(bma020fd,&acceldata,sizeof(acceldata));
        usleep(requested_delay);

        LOGV("data_poll data is %i / %i / %i",acceldata.x,acceldata.y,acceldata.z);
        if (acceldata.x==0 &&
                acceldata.y==0 &&
                acceldata.z==0) {
            // It looks like there's a limit on how much
            // data can be read before having to reopen
            // the device...

            LOGV("I'm probably not at the center of the earth nor in space... Rehash");
            close(bma020fd);
            bma020fd = open(BMA_DEVICE, O_RDONLY);
        }

        data->acceleration.x=acceldata.x*gravity;
        data->acceleration.y=(acceldata.y*gravity*-1);
        // For some reason, the Z axis appears to be off by 65. Why?
        // Is it just mine?
        data->acceleration.z=(acceldata.z-65)*gravity*-1;


    }


    if (calc_orientation) {
        calc_orientation = 0;

        double gravField=sqrt( (acceldata.x*acceldata.x)
                +(acceldata.y*acceldata.y)
                +(acceldata.z*acceldata.z));
        static float OneEightyOverPi = 57.29577957855f;

        // Would need a compass for this one :(
        data->orientation.azimuth=0; 

        data->orientation.roll = (asin(acceldata.x/(gravField * cos(asin(acceldata.y/gravField))))*OneEightyOverPi);
        data->orientation.pitch = (atan2(acceldata.y , -acceldata.z)*OneEightyOverPi);

#ifdef PRINT_VALUES
        temp_loop++;
        if (temp_loop >=20) {
            LOGD("Calculated orientation as %.3f / %.3f\n",data->orientation.roll,data->orientation.pitch);
            temp_loop = 0;
        }
#endif

        data->sensor=SENSOR_TYPE_ORIENTATION;
        data->type=SENSOR_TYPE_ORIENTATION;
        usleep(10000);

		LOGV("Returning accel data");
        return 1;
    } else {
        data->sensor=SENSOR_TYPE_ACCELEROMETER;

#ifdef PRINT_VALUES
        temp_aloop++;
        if (temp_aloop >=20) {
            LOGD("Calculated accel as %.3f / %.3f / %.3f\n",data->acceleration.x,data->acceleration.y,data->acceleration.z);
            temp_aloop = 0;
        }
#endif

        calc_orientation = 1;
        data->type=SENSOR_TYPE_ACCELEROMETER;

		LOGV("Returning accel data");
        return 1;
    }
}


int bma020_close(struct hw_device_t *dev) {
    LOGV("bma020_close");
    if (bma020fd > 0) {
        close(bma020fd);
        bma020fd=-1;
    }
    return 0;
}

typedef struct {
    struct sensors_poll_device_t device; // must be first

    int (*activate)(int handle, int enabled);
    int (*setDelay)(int handle, int64_t ns);
    int (*pollEvents)(sensors_event_t* data, int count);

} sensors_poll_context_t;

native_handle_t *open_data_source(struct sensors_control_device_t *dev) {
    LOGV("open_data_source");

    int fd = open(BMA_DEVICE, O_RDONLY);
    if(fd < 0)
        return NULL;

    native_handle_t *hdl=native_handle_create(1,0);
    hdl->data[0]=fd;
    return hdl;
}

static int close_data_source (struct hw_device_t *dev) {
	struct sensors_poll_device_t *ctx = (struct sensors_poll_device_t *)dev;
	if (ctx) {
		free(ctx);
	}
    return bma020_close(dev);
}

int activate(struct sensors_poll_device_t *dev, int handle, int enabled) {
    LOGV("activate - %d",enabled);
	if (enabled) {
		got_wake = 1;
	} else {
		got_wake = 0;
	}
    return 0;
}

int set_delay(struct sensors_poll_device_t *dev, int handle, int64_t ns) {
    LOGV("set_delay to %u\n",ns);

    /* Impose a minimum? // if (requested_delay<50) {
       requested_delay = 50;
       }*/
    requested_delay=(ns/1000);
    return 0;
}

int wake(struct sensors_control_device_t *dev) {
    LOGV("wake");
    got_wake = 1;
    return 0;
}

int bma020_open(const struct hw_module_t* module, const char* id, struct hw_device_t** device) {
    LOGV("bma020_open init");

        struct sensors_poll_device_t *dev;

        dev = malloc(sizeof(*dev));
        memset(dev, 0, sizeof(*dev));

        dev->common.tag = HARDWARE_DEVICE_TAG;
        dev->common.version = 0;
        dev->common.module = module;
        dev->common.close = close_data_source;
        dev->activate = activate;
        dev->setDelay = set_delay;
        dev->poll = data_poll;

        *device = &dev->common;

        return 0;

}


/*****************************
 *
 * Module definitions
 *
 *****************************/

struct sensor_t sensors[]={
    {
name            : "BMA020",
                  vendor          : "RC, on behalf of Geeksphone",
                  version         : 1,
                  handle          : SENSOR_TYPE_ACCELEROMETER,
                  type            : SENSOR_TYPE_ACCELEROMETER,
                  maxRange        : 20, /* 2 gravities? */
                  resolution      : 0.1,
                  power           : 20, /* No idea whatsoever... */
    },
    {
name            : "BMA020 orientation",
                  vendor          : "RC, on behalf of Geeksphone",
                  version         : 1,
                  handle          : SENSOR_TYPE_ORIENTATION,
                  type            : SENSOR_TYPE_ORIENTATION,
                  maxRange        : 20,
                  resolution      : 0.1,
                  power           : 20,
    }
};


static struct hw_module_methods_t device_methods = {
open : bma020_open,
};

int get_sensors_list(struct sensors_module_t *module, struct sensor_t const** list) {
    LOGV("get_sensors_list");
    *list=sensors;
    return sizeof(sensors)/sizeof(sensors[0]);;
};

const struct sensors_module_t HAL_MODULE_INFO_SYM = {
common : {
tag             : HARDWARE_MODULE_TAG,
                  version_major   : 1,
                  version_minor   : 0,
                  id              : SENSORS_HARDWARE_MODULE_ID,
                  author          : "Ricardo Cerqueira",
                  name            : "Bosch accelerometer driver",
                  methods         : &device_methods,
         },
get_sensors_list : get_sensors_list,
};
