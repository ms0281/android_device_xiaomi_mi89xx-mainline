#!/system/bin/sh

MEM_KB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
ZRAM_BYTES=$(awk -v mem="$MEM_KB" 'BEGIN { printf "%.0f\n", mem * 1024 * 0.75 }')

echo lz4 > /sys/block/zram0/comp_algorithm
echo "$ZRAM_BYTES" > /sys/block/zram0/disksize

/system/bin/toybox mkswap /dev/block/zram0
/system/bin/toybox swapon -p 32767 /dev/block/zram0
