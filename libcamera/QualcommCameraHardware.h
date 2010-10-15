/*
** Copyright 2008, Google Inc.
**
** Licensed under the Apache License, Version 2.0 (the "License"); 
** you may not use this file except in compliance with the License. 
** You may obtain a copy of the License at 
**
**     http://www.apache.org/licenses/LICENSE-2.0 
**
** Unless required by applicable law or agreed to in writing, software 
** distributed under the License is distributed on an "AS IS" BASIS, 
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
** See the License for the specific language governing permissions and 
** limitations under the License.
*/

#ifndef ANDROID_HARDWARE_QUALCOMM_CAMERA_HARDWARE_H
#define ANDROID_HARDWARE_QUALCOMM_CAMERA_HARDWARE_H

#include <camera/CameraHardwareInterface.h>
#include <binder/MemoryBase.h>
#include <binder/MemoryHeapBase.h>
#include <utils/threads.h>
#include <stdint.h>

extern "C" {
#include <linux/android_pmem.h>
//#include <media/msm_camera.h>
#include <rc_msm_camera.h>
}


#define MSM_CAMERA_CONTROL "/dev/msm_camera"

#define CAM_CTRL_SUCCESS 1

// 20 - seja la o que for, nao aceita valores absolutos superiores a 2...
#define CAMERA_SET_PARM_ENCODE_ROTATION 0
#define CAMERA_SET_PARM_DIMENSION 1
#define CAMERA_SET_PARM_ZOOM 2
#define CAMERA_SET_PARM_SENSOR_POSITION 3
#define CAMERA_SET_PARM_FOCUS_RECT 4
#define CAMERA_SET_PARM_LUMA_ADAPTATION 5
#define CAMERA_SET_PARM_CONTRAST 6
#define CAMERA_SET_PARM_BRIGHTNESS 7
#define CAMERA_SET_PARM_EXPOSURE_COMPENSATION 8
#define CAMERA_SET_PARM_SHARPNESS 9
#define CAMERA_SET_PARM_HUE 10
#define CAMERA_SET_PARM_SATURATION 11
#define CAMERA_SET_PARM_EXPOSURE 12
#define CAMERA_SET_PARM_AUTO_FOCUS 13
#define CAMERA_SET_PARM_WB 14
#define CAMERA_SET_PARM_EFFECT 15
#define CAMERA_SET_PARM_FPS 16
#define CAMERA_SET_PARM_FLASH 17
#define CAMERA_SET_PARM_NIGHTSHOT_MODE 18
#define CAMERA_SET_PARM_REFLECT 19
#define CAMERA_SET_PARM_PREVIEW_MODE 20
#define CAMERA_SET_PARM_ANTIBANDING 21
#define CAMERA_SET_PARM_RED_EYE_REDUCTION 22
#define CAMERA_SET_PARM_FOCUS_STEP 23
#define CAMERA_SET_PARM_EXPOSURE_METERING 24
#define CAMERA_SET_PARM_AUTO_EXPOSURE_MODE 25
#define CAMERA_SET_PARM_ISO 26
#define CAMERA_SET_PARM_BESTSHOT_MODE 27
#define CAMERA_SET_PARM_PREVIEW_FPS 28
#define CAMERA_SET_PARM_AF_MODE 29
#define CAMERA_SET_PARM_HISTOGRAM 30
#define CAMERA_SET_PARM_FLASH_STATE 31
#define CAMERA_SET_PARM_FRAME_TIMESTAMP 32
#define CAMERA_SET_PARM_STROBE_FLASH 33
#define CAMERA_SET_PARM_FPS_LIST 34
#define CAMERA_SET_PARM_DISPLAY_INFO 35
#define CAMERA_STOP_PREVIEW 36
#define CAMERA_START_PREVIEW 37
#define CAMERA_START_SNAPSHOT 38
#define CAMERA_START_RAW_SNAPSHOT 39
#define CAMERA_STOP_SNAPSHOT 40
#define CAMERA_EXIT 41

// Confirmados:
// 36: CAMERA_STOP_PREVIEW
// 37: CAMERA_START_PREVIEW
// 38: CAMERA_START_SNAPSHOT
// 39: CAMERA_START_RAW_SNAPSHOT
// 40: CAMERA_STOP_SNAPSHOT
// 41: CAMERA_EXIT
// Para obter os valores... trial and error: meter os valores a testar no
// start_preview, arrancar a camara, strace do mediaserver, e procurar a linha
// a seguir ao cam_conf:MSM_CAM_IOCTL_GET_STATS
//


typedef enum {
	AF_MODE_INFINITY,
	AF_MODE_MACRO,
	AF_MODE_AUTO,
} isp3a_af_mode_t;

#define CAMERA_AUTO_FOCUS_CANCEL 1 //204



typedef struct
{
    unsigned short picture_width;
    unsigned short picture_height;
    unsigned short display_width;
    unsigned short display_height;
    unsigned short orig_picture_dx;
    unsigned short orig_picture_dy;
    unsigned short ui_thumbnail_height;
    unsigned short ui_thumbnail_width;
    unsigned short thumbnail_height;
    unsigned short thumbnail_width;
    unsigned short filler5;
    unsigned short filler6;
    unsigned short filler7;
    unsigned short filler8;
} cam_ctrl_dimension_t;

typedef enum
{
    CAMERA_WB_MIN_MINUS_1,
    CAMERA_WB_AUTO = 1,  /* This list must match aeecamera.h */
    CAMERA_WB_CUSTOM,
    CAMERA_WB_INCANDESCENT,
    CAMERA_WB_FLUORESCENT,
    CAMERA_WB_DAYLIGHT,
    CAMERA_WB_CLOUDY_DAYLIGHT,
    CAMERA_WB_TWILIGHT,
    CAMERA_WB_SHADE,
    CAMERA_WB_MAX_PLUS_1
} camera_wb_type;

typedef enum
{
    CAMERA_RSP_CB_SUCCESS,    /* Function is accepted         */
    CAMERA_EXIT_CB_DONE,      /* Function is executed         */
    CAMERA_EXIT_CB_FAILED,    /* Execution failed or rejected */
    CAMERA_EXIT_CB_DSP_IDLE,  /* DSP is in idle state         */
    CAMERA_EXIT_CB_DSP_ABORT, /* Abort due to DSP failure     */
    CAMERA_EXIT_CB_ABORT,     /* Function aborted             */
    CAMERA_EXIT_CB_ERROR,     /* Failed due to resource       */
    CAMERA_EVT_CB_FRAME,      /* Preview or video frame ready */
    CAMERA_EVT_CB_PICTURE,    /* Picture frame ready for multi-shot */
    CAMERA_STATUS_CB,         /* Status updated               */
    CAMERA_EXIT_CB_FILE_SIZE_EXCEEDED, /* Specified file size not achieved,
                                          encoded file written & returned anyway */
    CAMERA_EXIT_CB_BUFFER,    /* A buffer is returned         */
    CAMERA_EVT_CB_SNAPSHOT_DONE,/*  Snapshot updated               */
    CAMERA_CB_MAX
} camera_cb_type;

typedef enum
{
    CAMERA_ANTIBANDING_OFF,
    CAMERA_ANTIBANDING_60HZ,
    CAMERA_ANTIBANDING_50HZ,
    CAMERA_ANTIBANDING_AUTO,
    CAMERA_MAX_ANTIBANDING,
} camera_antibanding_type;

typedef struct
{
    uint32_t timestamp;  /* seconds since 1/6/1980          */
    double   latitude;   /* degrees, WGS ellipsoid */
    double   longitude;  /* degrees                */
    int16_t  altitude;   /* meters                          */
} camera_position_type;

typedef struct
{
    uint8_t update_flag;
    unsigned int in1_w;
    unsigned int in1_h;
    unsigned int out1_w;
    unsigned int out1_h;
    unsigned int in2_w;
    unsigned int in2_h;
    unsigned int out2_w;
    unsigned int out2_h;
} common_crop_t;

typedef struct
{
    unsigned int maximum_value;
    unsigned int minimum_value;
    unsigned int current_value;
    unsigned int step_value;
} cam_parm_info_t;

typedef uint8_t cam_ctrl_type;
typedef uint8_t jpeg_event_t;

struct str_map {
    const char *const desc;
    int val;
};

#define JPEG_EVENT_DONE 0 /* guess */

#define CEILING16(x)  (((x)+0xf)&~0xf)
#define PAD_TO_WORD(x) (((x)+3)& ~3)

namespace android {

class QualcommCameraHardware : public CameraHardwareInterface {
public:

    virtual sp<IMemoryHeap> getPreviewHeap() const;
    virtual sp<IMemoryHeap> getRawHeap() const;
    virtual void setCallbacks(notify_callback notify_cb,
                              data_callback data_cb,
                              data_callback_timestamp data_cb_timestamp,
                              void* user);

    virtual void enableMsgType(int32_t msgType);
    virtual void disableMsgType(int32_t msgType);
    virtual bool msgTypeEnabled(int32_t msgType);

    virtual status_t dump(int fd, const Vector<String16>& args) const;
    virtual status_t startPreview();
    virtual void stopPreview();
    virtual bool previewEnabled();
    virtual status_t startRecording();
    virtual void stopRecording();
    virtual bool recordingEnabled();
    virtual void releaseRecordingFrame(const sp<IMemory>& mem);
    virtual status_t autoFocus();
    virtual status_t takePicture();
    virtual status_t cancelPicture();
    virtual status_t setParameters(const CameraParameters& params);
    virtual CameraParameters getParameters() const;
    virtual status_t sendCommand(int32_t command, int32_t arg1, int32_t arg2);
    virtual void release();
    virtual status_t cancelAutoFocus();

    static sp<CameraHardwareInterface> createInstance();
    static sp<QualcommCameraHardware> getInstance();

    void receivePreviewFrame(struct msm_frame_t *frame);
    void receiveJpegPicture(void);
    void jpeg_set_location();
    void receiveJpegPictureFragment(uint8_t *buf, uint32_t size);
    void notifyShutter();

private:
    QualcommCameraHardware();
    virtual ~QualcommCameraHardware();
    status_t startPreviewInternal();
    void stopPreviewInternal();
    friend void *auto_focus_thread(void *user);
    void runAutoFocus();
    bool native_set_dimension (int camfd);
    bool native_jpeg_encode (void);
    bool native_set_parm(cam_ctrl_type type, uint16_t length, void *value);
    bool native_set_dimension(cam_ctrl_dimension_t *value);

    int getParm(const char *parm_str, const str_map *parm_map);

    static wp<QualcommCameraHardware> singleton;

    /* These constants reflect the number of buffers that libmmcamera requires
       for preview and raw, and need to be updated when libmmcamera
       changes.
    */
    static const int kPreviewBufferCount = 4;
    static const int kRawBufferCount = 1;
    static const int kJpegBufferCount = 1;

    //TODO: put the picture dimensions in the CameraParameters object;
    CameraParameters mParameters;
    int mPreviewHeight;
    int mPreviewWidth;
    int mRawHeight;
    int mRawWidth;
    unsigned int frame_size;
    bool mCameraRunning;
    bool mPreviewInitialized;

    // This class represents a heap which maintains several contiguous
    // buffers.  The heap may be backed by pmem (when pmem_pool contains
    // the name of a /dev/pmem* file), or by ashmem (when pmem_pool == NULL).

    struct MemPool : public RefBase {
        MemPool(int buffer_size, int num_buffers,
                int frame_size,
                int frame_offset,
                const char *name);

        virtual ~MemPool() = 0;

        void completeInitialization();
        bool initialized() const {
            return mHeap != NULL && mHeap->base() != MAP_FAILED;
        }

        virtual status_t dump(int fd, const Vector<String16>& args) const;

        int mBufferSize;
        int mNumBuffers;
        int mFrameSize;
        int mFrameOffset;
        sp<MemoryHeapBase> mHeap;
        sp<MemoryBase> *mBuffers;

        const char *mName;
    };

    struct AshmemPool : public MemPool {
        AshmemPool(int buffer_size, int num_buffers,
                   int frame_size,
                   int frame_offset,
                   const char *name);
    };

    struct PmemPool : public MemPool {
        PmemPool(const char *pmem_pool,
                 int control_camera_fd, int pmem_type,
                 int buffer_size, int num_buffers,
                 int frame_size, int frame_offset,
                 const char *name);
        virtual ~PmemPool();
        int mFd;
        int mPmemType;
        int mCameraControlFd;
        uint32_t mAlignedSize;
        struct pmem_region mSize;
    };

    sp<PmemPool> mPreviewHeap;
    sp<PmemPool> mThumbnailHeap;
    sp<PmemPool> mRawHeap;
    sp<AshmemPool> mJpegHeap;

    void startCamera();
    bool initPreview();
    void deinitPreview();
    bool initRaw(bool initJpegHeap);
    void deinitRaw();

    bool mFrameThreadRunning;
    Mutex mFrameThreadWaitLock;
    Condition mFrameThreadWait;
    friend void *frame_thread(void *user);
    void runFrameThread(void *data);

    bool mShutterPending;
    Mutex mShutterLock;

    bool mSnapshotThreadRunning;
    Mutex mSnapshotThreadWaitLock;
    Condition mSnapshotThreadWait;
    friend void *snapshot_thread(void *user);
    void runSnapshotThread(void *data);

    void initDefaultParameters();


    void setZoom();
    void setAntibanding();
    void setEffect();
    void setWhiteBalance();
    void setSaturation();
    void setContrast();
    void setSharpness();
    void setBrightness();
    void setRotation();
    void setISOValue();
    void setFocusMode();
    void setAutoExposure();

    Mutex mLock;
    bool mReleasedRecordingFrame;

    void receiveRawPicture(void);


    Mutex mRecordLock;
    Mutex mRecordFrameLock;
    Condition mRecordWait;
    Condition mStateWait;

    /* mJpegSize keeps track of the size of the accumulated JPEG.  We clear it
       when we are about to take a picture, so at any time it contains either
       zero, or the size of the last JPEG picture taken.
    */
    uint32_t mJpegSize;

    notify_callback    mNotifyCb;
    data_callback      mDataCb;
    data_callback_timestamp mDataCbTimestamp;
    void               *mCallbackCookie;

    int32_t             mMsgEnabled;

    unsigned int        mPreviewFrameSize;
    int                 mRawSize;
    int                 mJpegMaxSize;

#if DLOPEN_LIBMMCAMERA
    void *libmmcamera;
    void *libmmcameratarget;
#endif

    int mCameraControlFd;
    cam_ctrl_dimension_t mDimension;
    bool mAutoFocusThreadRunning;
    Mutex mAutoFocusThreadLock;
    int mAutoFocusFd;

    pthread_t mCamConfigThread;
    pthread_t mFrameThread;
    pthread_t mSnapshotThread;

    common_crop_t mCrop;

    struct msm_frame_t frames[kPreviewBufferCount];
    bool mInPreviewCallback;
    bool mCameraRecording;

    // Avoid unnecessary ioctls, store prev values
    int mCurBrightness;
    int mCurZoom;
};

}; // namespace android

#endif
