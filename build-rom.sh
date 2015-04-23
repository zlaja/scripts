#!/bin/bash
# Add ~/bin to path
export PATH=$PATH:~/bin

NumThreads=`grep 'processor' /proc/cpuinfo | wc -l`

echo ""
echo ""
echo "     -- SlimRoms --"
echo ""
echo ""

while [ "$progress" != "finished" ]; do
echo "1) Sync source"
echo "2) Make clean"
echo "3) Build ROM"
echo "4) Close"
echo ""
echo ""
echo "Sync source - Downloads the latest changes in source code. Always run this before building."
echo "Make clean - Deletes OUT folder so ROM can be built from scratch. Optional, but recommended."
echo "Build ROM - Self explainatory. It will take some time. Sit back and relax. :)"
echo "Close - Exits this script."
echo ""
echo ""
echo -n "Select an option: "
read option
echo ""
echo ""

case  $option in
  1)
    echo "Syncing sources..."
    repo sync -j$NumThreads
    ;;
  2)
    echo "Cleaning OUT directory..."
    make clean -j$NumThreads
    ;;
  3)
    echo "Building ROM..."
    . build/envsetup.sh && lunch slim_w5-userdebug && make -j$NumThreads bacon
    progress=finished
    ;;
  4)
	echo "Exiting... Thank you!"
    progress=finished
	;;
  *)
    echo "Error: not defined!"
esac
echo ""
echo ""
done
