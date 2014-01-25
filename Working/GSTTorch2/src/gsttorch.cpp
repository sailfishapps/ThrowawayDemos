//thanks to:
// http://developer.nokia.com/Community/Wiki/How_to_turn_your_camera_flash_into_a_torch_on_Harmattan_using_GStreamer
// http://docs.gstreamer.com/display/GstSDK/Basic+tutorial+2%3A+GStreamer+concepts

#include "gsttorch.h"
#include <gst/gst.h>
#include <QDebug>

GstTorch::GstTorch(QObject *parent) :
    QObject(parent), pipeline(0), src(0), sink(0), timer(0), mTorchOn(false), mtorchMode(Beam), mStatus(offBeam)
{
    initTorch();
    initTimer();
}

void GstTorch::initTorch() {
    qDebug() << "torch initialising";
    //gst-launch-0.10 droidcamsrc video-torch=1 viewfinder-mode=1 ! fakesink
    gst_init(NULL, NULL);
    src = gst_element_factory_make("droidcamsrc", "src");
    sink = gst_element_factory_make("droideglsink", "sink");
    pipeline = gst_pipeline_new ("test-pipeline");
    if (!src || !sink || !pipeline) {
        return;
    }
    /* Build the pipeline */
    gst_bin_add_many (GST_BIN (pipeline), src, sink, NULL);
    if (gst_element_link (src, sink) != TRUE) {
        qDebug() << "Elements could not be linked!";
        gst_object_unref (pipeline);
        return;
    }
    g_object_set(G_OBJECT(src), "video-torch", 1, NULL);
    g_object_set(G_OBJECT(src), "mode", 2, NULL);
    gst_element_set_state(pipeline, GST_STATE_NULL);
}

void GstTorch::initTimer() {
    qDebug() << "timer initialising";
    timer = new QTimer(this);
    timer->setInterval(500);
    timer->setSingleShot(false);
    QObject::connect(timer, SIGNAL(timeout()), this, SLOT(flashEvent()));
}

GstTorch::~GstTorch()
{
    if(timer)
        timer->stop();
    delete timer;
}


void GstTorch::start(){
    qDebug() << "START";
    gst_element_set_state(pipeline, GST_STATE_PLAYING);
}

void GstTorch::stop(){
    qDebug() << "STOP";
    gst_element_set_state(pipeline, GST_STATE_NULL);
}

//this is the entry point from QML to turn torch on or off
void GstTorch::toggleTorchOnOff(){
    qDebug() << "TOGGLE TORCH ON / OFF from" << mTorchOn << "to" << !mTorchOn;
    setTorchOn(!mTorchOn);
}

bool  GstTorch::torchOn(){
    qDebug() << "torchOn: " << mTorchOn;
    return mTorchOn;
}

void  GstTorch::setTorchOn(bool on){
    qDebug() << "SET TORCH ON / OFF" << on;
    if (on){
        start();
        if (mtorchMode == Flash){
            timer->start();
        }
    } else {
        stop();
        if (mtorchMode == Flash){
            timer->stop();
        }
        mStatus = offBeam;
    }
    setStatus(on, mtorchMode, false);
    mTorchOn = on;
    emit torchOnChanged(on);
}

void GstTorch::toggleTorchMode(){
    qDebug() << "TOGGLE TORCH MODE FLASH / BEAM";
    if (mtorchMode == Beam) {
        setTorchMode(Flash);
    }
    else if (mtorchMode == Flash) {
        setTorchMode(Beam);
    }
}

GstTorch::Mode GstTorch::torchMode(){
    qDebug() << "FLASHING MODE";
    return mtorchMode;
}

void  GstTorch::setTorchMode(Mode mode){
    qDebug() << "SET TORCH MODE" << mode;
    if (mode == Flash){
        if (mStatus == onBeam){
            timer->start();
        }
    }
    else if (mode == Beam) {
        timer->stop();
        if (mStatus == onFlashOff) {
            start();
        }
    }
    setStatus(mTorchOn, mode, false);
    mtorchMode = mode;
    emit torchModeChanged(mode);
}

void GstTorch::flashEvent(){
    qDebug() << "FLASH EVENT";
    //don't emit any signals
    //if we turn the torch "off" due to a flash event, from an outside view it is still on
    if (mStatus == onFlashOn) {
        setStatus(mTorchOn, mtorchMode, false);
        stop();
    }
    else if (mStatus == onFlashOff) {
        setStatus(mTorchOn, mtorchMode, true);
        start();
    }
    //for other states, do nothing
}

void GstTorch::setStatus(bool torchOn, Mode torchMode, bool flashOn){
    //{offBeam, onBeam, onFlashOn, onFlashOff, offFlash}
    if ( torchOn && (torchMode == Beam) ) {
        mStatus = onBeam;
    }
    if ( torchOn && (torchMode == Flash) && flashOn) {
        mStatus = onFlashOn;
    }
    if ( torchOn && (torchMode == Flash) && !flashOn) {
        mStatus = onFlashOff;
    }
    if ( !torchOn && (torchMode == Beam) ) {
        mStatus = offBeam;
    }
    if ( !torchOn && (torchMode == Flash) ) {
        mStatus = offFlash;
    }
}

