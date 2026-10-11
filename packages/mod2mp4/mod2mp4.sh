WORK_DIR=$1
if [ ! -d "$WORK_DIR" ]; then
    echo "ERROR: missing directory!"
    echo "usage: $(basename \$0) [directory]"
fi

# ignore file extension case
shopt -s nocaseglob

ARCHIVE_DIR="$WORK_DIR/MOD_Archive"
mkdir -p "$ARCHIVE_DIR"

convert_file() {
    local modfile=$1
    filename=$(basename "$modfile")
    file_no_ext="${filename%.*}"
    output_file="$WORK_DIR/${file_no_ext}.mp4"

    echo "  🗘 converting: $filename"

    # convert .mod to .mp4 using ffmpeg
    if ffmpeg -i "$modfile" -vf "yadif" "$output_file" 2>/dev/null; then
        echo "  ✓ successfully converted: $filename ➜ ${file_no_ext}.mp4"

        touch -r "$modfile" "$output_file"               # preserve created at and modified at metadata
        mv "$modfile" "$file_no_ext.MOI" "$ARCHIVE_DIR/" # move original file to archive
        echo "  🖬 moved to archive: $filename"
    else
        echo "  ✗ failed to convert: $filename"
    fi
}

N=7
for modfile in "$WORK_DIR"/*.mod; do
    [ -f "$modfile" ] || break

    ((i = i % N))
    ((i++ == 0)) && wait

    convert_file "$modfile" &
done

wait

notify-send -i camera-video --app-name mod2mp4 "💿 conversion complete!" "mod2mp4 has finsihed!"

echo "  💿 conversion complete!"
