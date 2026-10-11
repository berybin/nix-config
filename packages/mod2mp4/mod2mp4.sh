if [ ! $# -ge 1 ]; then
    echo "ERROR: missing arg!"
    echo "usage: $(basename "$0") [directory]"
    exit 1
fi

WORK_DIR=$1
if [ ! -d "$WORK_DIR" ]; then
    echo "ERROR: $WORK_DIR is an invalid directory"
    echo "usage: $(basename "$0") [directory]"
    exit 1
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

        touch -r "$modfile" "$output_file"                         # preserve created at and modified at metadata
        mv "$modfile" "$WORK_DIR/$file_no_ext.MOI" "$ARCHIVE_DIR/" # move original file to archive
        echo "  🖬 moved to archive: $filename"
    else
        echo "  ✗ failed to convert: $filename"
    fi
}

# convert files in batches of 10
N=10
i=0
for modfile in "$WORK_DIR"/*.mod; do
    [ -f "$modfile" ] || continue
    convert_file "$modfile" &
    i=$((i + 1))
    if ((i % N == 0)); then
        wait
    fi
done
wait

mv "$WORK_DIR"/*.PGI "$ARCHIVE_DIR" # move whatver the PGI file is to the archive too
notify-send -i camera-video --app-name mod2mp4 "💿 conversion complete!" "mod2mp4 has finsihed!"
echo "  💿 conversion complete!"
