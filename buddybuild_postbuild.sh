#!/usr/bin/env bash

echo "Uploading IPAs and dSYMs to Crashlytics"

CRASHLYTICS_API_KEY=e8586ed0363ddcd4fc38b8f3aff4d3e095de5f07
echo "Uploading to Fabric via command line"  
$BUDDYBUILD_WORKSPACE/Pods/Fabric/upload-symbols -a $CRASHLYTICS_API_KEY -p ios $BUDDYBUILD_PRODUCT_DIR
