#!/usr/bin/env bash

# Hi this is my epic script to install fonts, to use it:
# use <comand-name> <FILENAME> (Add more if needed)
# For each file argument:
#     ├─ Does file exist? 
#     │   └─ No → skip it
#     │   └─ Yes → continue
#     │
#     ├─ Is it a .zip?
#     │   └─ Yes → extract, find fonts, copy them
#     │
#     ├─ Is it a .ttf?
#     │   └─ Yes → copy directly
#     │
#     ├─ Is it a .otf?
#     │   └─ Yes → copy directly
#     │
#     └─ None of the above?
#         └─ Show warning and skip

# After all files processed:
#     └─ Update font cache once

# INSTRUCTIONS TO INSTALL


# ===============================Start of Script======================================
echo "Number of args: $#"
echo "List of args: $@"

# Check if there are ARGS (if = to 0), if so exit
if [ $# -eq 0 ]; then
    echo "Usage: $0 <font-file.zip or .ttf/.otf> [additional-files...]"
    exit 1
fi

# Make sure fonts directory exists
mkdir -p ~/.local/share/fonts

# For each arg in all-args do the epic gamer
for font_file in "$@"; do
    echo "Processing: $font_file"
    
    # Check if file exists, if not, go to next arg in parent loop
    if [ ! -f "$font_file" ]; then
        echo "Error: '$font_file' not found"
        continue # epic skipper
    fi

    # ====================================Handle and convert file/archives==============================================
    # Handle ZIP files if they exist, if zip not there, 
        # refer to the checks that handle indevidual file types
    if [[ "$font_file" == *.zip ]]; then
        echo "Detected zip file, extracting..."
        
        # Create temp directory
        temp_dir=$(mktemp -d)
        echo "Created temp directory: $temp_dir"
        
        # Setup cleanup (runs when script exits)
        trap "rm -rf '$temp_dir'" EXIT
        
        # Unzip (fixed the = typo)
        unzip -q "$font_file" -d "$temp_dir"
        
        # Count how many fonts we found, ans stores them in a var
        font_count=$(find "$temp_dir" -type f \( -name "*.ttf" -o -name "*.otf" \) | wc -l) # "\(...)" is a group condition? "wc -l" is word count in lines
        
        # from font_count, check if 0, if zero skip iteration to next arg
        if [ "$font_count" -eq 0 ]; then
            echo "Warning: No font files found in $font_file"
            continue
        fi
        
        echo "Found $font_count font file(s)"
        
        # Copy all font files (both .ttf and .otf)
            # First, within temp_dir(find all files that are types .ttf and .otf) 
            # Next, <with that info> execute-command(-exec)(copies the temp placeholder("{}") to the home share folder for fonts) 
        find "$temp_dir" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} ~/.local/share/fonts/ \; # "\;" marks the end of the -exec comand sequence
        
        echo "Copied fonts from $font_file" # success!
    
    # ========================================Other options for processing========================================================
    
    # Handle individual .ttf files
    elif [[ "$font_file" == *.ttf ]]; then
        echo "Detected .ttf file, copying directly..."
        cp "$font_file" ~/.local/share/fonts/
        echo "Copied $font_file"
        
    # Handle individual .otf files
    elif [[ "$font_file" == *.otf ]]; then
        echo "Detected .otf file, copying directly..."
        cp "$font_file" ~/.local/share/fonts/
        echo "Copied $font_file"
        
    else
        echo "Warning: '$font_file' is not a .zip, .ttf, or .otf file - skipping"
    fi
    
done # End of main loop

# ===================================Clean up==============================================
# Update font cache once at the end (more efficient)
echo ""
echo "Updating font cache..."

# fc-cache = fontconfig cache command - tells the system to recognize the new fonts
    # -f = force - rebuild cache even if it seems up-to-date
    # -v = verbose - show what it's doing
    # Why at the end? More efficient to update cache once after all fonts are installed, rather than after each file
fc-cache -fv # refesh 

echo ""
echo "All done! Fonts installed successfully."