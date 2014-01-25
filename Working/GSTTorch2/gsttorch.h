#ifndef GSTTORCH_H
#define GSTTORCH_H

#include <QObject>
#include <gst/gstelement.h>
#include <QTimer>

class GstTorch : public QObject
{
    Q_OBJECT
    Q_ENUMS(Status)
    Q_ENUMS(Mode)

public:
    enum Status { offBeam, onBeam, onFlashOn, onFlashOff, offFlash };
    enum Mode { Beam, Flash };
    Q_PROPERTY(bool torchOn READ torchOn WRITE setTorchOn NOTIFY torchOnChanged)
    Q_PROPERTY(Mode torchMode READ torchMode WRITE setTorchMode NOTIFY torchModeChanged)
    explicit GstTorch(QObject *parent = 0);
    ~GstTorch();

    void start();
    void stop();
    Q_INVOKABLE void toggleTorchOnOff();
    Q_INVOKABLE void toggleTorchMode(); // toggle between Beam and Torch

    bool torchOn();
    Mode torchMode();
    void setTorchOn(bool on);
    void setTorchMode(Mode mode);

signals:
    void torchOnChanged(bool on);
    void torchModeChanged(Mode mode);

protected slots:
    void flashEvent();

private:
    void initTorch();
    void initTimer();
    void setStatus(bool torchOn, Mode torchMode, bool flashOn);

    GstElement *pipeline;
    GstElement *src;
    GstElement *sink;
    QTimer *timer;
    bool mTorchOn; // true = on
    Mode mtorchMode; // true = on, i.e if the torch is active, it will flash.
    Status mStatus;

};

#endif // GSTTORCH_H
