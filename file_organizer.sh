#!/bin/bash

#  CONFIGURATION 
TARGET_DIR="$HOME/Downloads"
DRY_RUN=true    # This allows a test mode without actually moving files if set to true. if set to false, files will moves according to the scrips
LOG_FILE="$TARGET_DIR/organizer_log.txt"

# HELPER: Log function
log_action() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

# HELPER: Create folder if it doesn't exist 
ensure_dir() {
    [ ! -d "$1" ] && mkdir -p "$1"
}

# CATEGORY MAPPING FUNCTION 
get_category() {
    local ext="${1,,}"  # Take the first argument, convert it to lowercase,and store it in ext

    if [[ "$ext" == "jpg" || "$ext" == "jpeg" || "$ext" == "png" || "$ext" == "gif" || "$ext" == "bmp" || "$ext" == "svg" ]]; then
        echo "Images"
    elif [[ "$ext" == "mp4" || "$ext" == "mkv" || "$ext" == "mov" || "$ext" == "avi" || "$ext" == "webm" ]]; then
        echo "Videos"
    elif [[ "$ext" == "mp3" || "$ext" == "wav" || "$ext" == "flac" || "$ext" == "aac" ]]; then
        echo "Audio"
    elif [[ "$ext" == "pdf" ]]; then
        echo "PDFs"
    elif [[ "$ext" == "zip" || "$ext" == "tar" || "$ext" == "gz" || "$ext" == "rar" || "$ext" == "7z" ]]; then
        echo "Archives"
    elif [[ "$ext" == "doc" || "$ext" == "docx" || "$ext" == "xls" || "$ext" == "xlsx" || "$ext" == "ppt" || "$ext" == "pptx" || "$ext" == "odt" ]]; then
        echo "Documents"
    elif [[ "$ext" == "txt" || "$ext" == "md" || "$ext" == "rtf" || "$ext" == "csv" ]]; then
        echo "TextFiles"
    else
	echo "Others"
    fi
}

# MAIN ORGANIZING FUNCTION 
organize_files() {
    echo "Organizing files in $TARGET_DIR..."
    for file in "$TARGET_DIR"/*; do
        [ -f "$file" ] || continue  # Skip if not a regular file

        filename=$(basename "$file") # This takes a full path to a file and return just the filename part. e.g, picture.jpg
        extension="${filename##*.}" # This extract the file extension, if filename is my.doc.pdf, ##*. will remove my.doc leaving just pdf.

        # Skip if no extension
        [ "$filename" = "$extension" ] && continue

        category=$(get_category "$extension")
        dest_dir="$TARGET_DIR/$category" # create the destination directory path
        dest_path="$dest_dir/$filename" # create the full path for new location of the file

        ensure_dir "$dest_dir"

        if $DRY_RUN; then
            echo "[DRY RUN] Would move: $filename → $category/"
        else
            mv -n "$file" "$dest_path" && \
            echo "Moved: $filename → $category/" && \
            log_action "Moved $filename to $category/"
        fi
    done

    echo "Done."
    $DRY_RUN && echo "Dry run: test mode complete."
}

# ENTRY POINT
organize_files
