{
  pkgs,
  concurrentConversions ? 5,
  ...
}:
let
  ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
in

pkgs.writeShellScriptBin "mod2mp4" ''
  WORKING_DIR=$(pwd)

  OUTPUT_DIR="$WORKING_DIR"
  ARCHIVE_DIR="$WORKING_DIR/archive"

  mkdir -p "$OUTPUT_DIR" "$ARCHIVE_DIR"

  # ignore file extension case
  shopt -s nocaseglob

  convert_file() {
      modfile=$1
      filename=$(basename "$modfile")
      file_no_ext="''${filename%.*}"

      output_file="$OUTPUT_DIR/''${file_no_ext}.mp4"

      echo "  🗘 converting: $filename"

      failed+=("$filename")

      # convert .mod to .mp4 using ffmpeg
      # re-encode to H.264/AAC
      if ${ffmpeg} -i "$modfile" -vf "yadif,format=yuv420p" -aspect 16:9 -c:v libx264 -crf 18 -c:a aac "$output_file" -y 2>/dev/null; then
          echo "  ✓ successfully converted: $filename ➜ ''${file_no_ext}.mp4"

          # preserve created at and modified at metadata
          touch -r "$modfile" "$output_file"

          # move original file to archive
          mv "$modfile" "$ARCHIVE_DIR/"
          echo "  🖬 moved to archive: $filename"
          echo
      else
          echo "  ✗ failed to convert: $filename"
      fi
  }

  N=${toString concurrentConversions}
  for modfile in "$WORKING_DIR"/*.mod; do
      [ -f "$modfile" ] || break

      ((i = i % N))
      ((i++ == 0)) && wait

      convert_file "$modfile" &
  done

  wait

  ${notify-send} -i camera-video --app-name mod2mp4 "💿 conversion complete!" "mod2mp4 has finsihed!"

  echo
  echo "  💿 conversion complete!"
''
