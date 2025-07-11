# File Organizer Script

A simple, automated Bash script that organizes files in your `Downloads` directory into categorized folders (like `PDFs`, `Images`, `Archives`, etc.) based on their file types.

---

## Features

- Sorts files by type (PDFs, images, videos, etc.)
- Automatically creates folders if they don't exist
- Optional **Dry Run** mode (simulates without moving files)
- Logs every move operation in a log file
- Works with common file types, customizable for more

---

## Prerequisites

- Linux or macOS
- Bash 4+
- Basic file permissions to read/write in your Downloads directory

---

## Installation

1. Clone this repository:

```bash
git clone https://github.com/Donchuks02/File-Organizer-Script
cd file-organizer-script
```

2. make the script executable :

```bash
chmod +x file_organizer.sh
```

## How to use
Run the script:

```bash
./file_organizer.sh
```
By default, it organizes your ~/Downloads folder and writes a log to ~/Downloads/organizer_log.txt


## Customization

- Change target directory
   Edit the TARGET_DIR variable inside the script to point to any directory you want to organize.

```bash
TARGET_DIR="$HOME/Downloads"
```


- Enable Dry Run mode
  Preview what the script would do without moving any files:

```bash
DRY_RUN=true
```

## Example Output

```bash
Moved: resume.pdf → PDFs/
Moved: screenshot.png → Images/
Moved: movie.mp4 → Videos/
```