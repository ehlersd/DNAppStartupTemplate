Xcode Project README

Scheme Test post-action Run Scripts:

/bin/sh

#-----------------------------
#xcode build pre-action script - redirect output to file
echo "Xcode Scheme Test Post-action Script" > $SOURCE_ROOT/xcodeActionsTest.txt
echo "$PROJECT_NAME : $TARGET_NAME" >> $SOURCE_ROOT/xcodeActionsTest.txt
date '+%m-%d-%y.%H%M%S' >> $SOURCE_ROOT/xcodeActionsTest.txt

cd "$SOURCE_ROOT/.."

echo "CURRENT_ARCH=$CURRENT_ARCH" >> $SOURCE_ROOT/xcodeActionsTest.txt
echo "NATIVE_ARCH=$NATIVE_ARCH" >> $SOURCE_ROOT/xcodeActionsTest.txt

RUNNING_ARCH="$CURRENT_ARCH"
if [ "$RUNNING_ARCH" = "undefined_arch" ] ; then
    RUNNING_ARCH="i386"
fi

EXPORT_PATH="$PWD/Coverage"
SOURCE_PATH="$PROJECT_TEMP_DIR/$CONFIGURATION-iphonesimulator/$PROJECT_NAME.build/Objects-$CURRENT_VARIANT/$RUNNING_ARCH"

echo "SOURCE_PATH=$SOURCE_PATH" >> $SOURCE_ROOT/xcodeActionsTest.txt
echo "EXPORT_PATH=$EXPORT_PATH" >> $SOURCE_ROOT/xcodeActionsTest.txt

if [ -d "$SOURCE_PATH" ] ; then
    if [ "$RUNNING_ARCH" = "i386" ] ; then
        # remove previous coverage results
        echo "##[progressStart 'Clearing Previous Coverage results']" >> $SOURCE_ROOT/xcodeActionsTest.txt
        rm -rf Coverage >> $SOURCE_ROOT/xcodeActionsTest.txt
        echo "##[progressFinish 'Clearing Previous Coverage results']" >> $SOURCE_ROOT/xcodeActionsTest.txt

        # collect coverage results
        echo "##[progressStart 'Collecting Coverage results']" >> $SOURCE_ROOT/xcodeActionsTest.txt
        osascript coverage.scpt $SOURCE_PATH $EXPORT_PATH >> $SOURCE_ROOT/xcodeActionsTest.txt
        echo "##[progressFinish 'Collecting Coverage results']" >> $SOURCE_ROOT/xcodeActionsTest.txt
    fi
fi

echo "done!" >> $SOURCE_ROOT/xcodeActionsTest.txt
