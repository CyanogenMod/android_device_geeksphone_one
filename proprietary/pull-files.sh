#!/bin/sh

echo "Please connect your phone to USB"
adb wait-for-device
echo "Phone connected. Pulling files"

echo "    -------------------- Wifi AR6002 firmware files..."
for f in athwlan.bin.z77 data.patch.hw2_0.bin eeprom.bin;
	do adb pull /system/etc/wifi/fw/$f ./
done

echo "    -------------------- Bluetooth helpers"
adb pull /system/bin/hci_qcomm_init ./
adb pull /system/etc/init.qcom.bt.sh ./

echo "    -------------------- Radio and associated libraries"
for f in libcm.so libdsm.so libdss.so libgsdi_exp.so libgstk_exp.so libmmgsdilib.so libnv.so liboem_rapi.so liboncrpc.so libqmi.so libqueue.so libril-qc-1.so libwms.so libwmsts.so libsnd.so
	do adb pull /system/lib/$f ./
done

echo "    -------------------- Camera control and encoding libraries"
for f in libmmcamera.so libmmcamera_target.so libmmjpeg.so
	do adb pull /system/lib/$f ./
done

echo "    -------------------- Media libraries"
for f in libmm-adspsvc.so libOmxH264Dec.so libOmxMpeg4Dec.so libOmxVidEnc.so
	do adb pull /system/lib/$f ./
done

echo "    -------------------- GPS library"
adb pull /system/lib/libgps.so ./

echo "    -------------------- DONE. check the above lines for errors"
