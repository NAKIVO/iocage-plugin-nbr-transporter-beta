#!/bin/sh

PRODUCT='NAKIVO Backup & Replication (Beta)'
URL="https://d96i82q710b04.cloudfront.net/res/product/beta/NAKIVO_Transporter_Installer_9.0.0_BETA.sh "
SHA256="c37d4e9fc5d02aadcb06e68c47db2a4ddc8ee94e570e15f5895f6ef6bbd35ea9"

PRODUCT_ROOT="/usr/local/nakivo"
INSTALL="inst.sh"

curl --fail --tlsv1.2 -o $INSTALL $URL
if [ $? -ne 0 -o ! -e $INSTALL ]; then
    echo "ERROR: Failed to get $PRODUCT installer"
    rm $INSTALL >/dev/null 2>&1
    exit 1
fi

CHECKSUM=`sha256 -q $INSTALL`
if [ "$SHA256" != "$CHECKSUM" ]; then
    echo "ERROR: Incorrect $PRODUCT installer checksum"
    rm $INSTALL >/dev/null 2>&1
    exit 2
fi

sh ./$INSTALL -s -i "$PRODUCT_ROOT" --eula-accept 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: $PRODUCT install failed"
    rm $INSTALL >/dev/null 2>&1
    exit 3
fi
rm $INSTALL >/dev/null 2>&1

exit 0