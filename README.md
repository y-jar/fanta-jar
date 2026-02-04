# fnta - Font Installer

A simple bash script to easily install fonts (`.ttf`, `.otf`, or `.zip` archives) on Linux systems.
I made this because i kinda kept forgetting how to install fonts on linux after installing a patched nerdfont for my neovim journey.

## Features

- 📦 Install fonts from `.zip` archives
- 🔤 Install individual `.ttf` and `.otf` files
- 🚀 Process multiple files at once
- 🔄 Automatically updates font cache
- ✨ Clean and simple to use

## Installation

### Quick Install (Recommended)

1. **Download the script**
   ```bash
   # If you have the script already, skip to step 2
   ```

2. **Create your local bin directory**
   ```bash
   mkdir -p ~/.local/bin
   ```

3. **Move and rename the script**
   ```bash
   mv install-fonts.sh ~/.local/bin/fnta
   ```

4. **Make it executable**
   ```bash
   chmod +x ~/.local/bin/fnta
   ```

5. **Add to your PATH** (if not already there)
   
   For **Bash** users:
   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```
   
   For **Zsh** users:
   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

6. **Verify installation**
   ```bash
   which fnta
   ```
   You should see: `/home/yourusername/.local/bin/fnta`

### Alternative: System-Wide Installation

If you want all users on your system to access `fnta`:

```bash
sudo cp install-fonts.sh /usr/local/bin/fnta
sudo chmod +x /usr/local/bin/fnta
```

## Usage

### Basic Examples

**Install a single font archive:**
```bash
fnta NerdFont.zip
```

**Install individual font files:**
```bash
fnta Font-Regular.ttf
fnta Font-Bold.otf
```

**Install multiple files at once:**
```bash
fnta Font1.zip Font2.ttf Font3.otf
```

**Install all zips in current directory:**
```bash
fnta *.zip
```

### What It Does

1. Checks if the files exist
2. For `.zip` files: extracts them and copies all `.ttf` and `.otf` files inside
3. For `.ttf` or `.otf` files: copies them directly
4. Installs fonts to `~/.local/share/fonts/`
5. Updates your system's font cache so the fonts are immediately available

## Requirements

- Linux operating system
- `bash` shell
- `unzip` command (install with `sudo <package-manager> install unzip` if missing)
- `fontconfig` for font cache updates (usually pre-installed)

## Troubleshooting

**Command not found after installation:**
- Make sure `~/.local/bin` is in your PATH: `echo $PATH | grep ".local/bin"`
- Reload your shell: `source ~/.bashrc` or `source ~/.zshrc`
- Restart your terminal

**Fonts not showing up:**
- Close and reopen applications using fonts
- Run `fc-cache -fv` manually to force cache update
- Check if fonts were copied in the folder: `ls ~/.local/share/fonts/`

**Permission denied:**
- Make sure the script is executable: `chmod +x ~/.local/bin/fnta`

## Uninstall

To remove `fnta`:

```bash
rm ~/.local/bin/fnta
```

Fonts installed will remain in `~/.local/share/fonts/` unless you delete them manually.

## Example Workflow

```bash
# Download a Nerd Font
cd ~/Downloads

# Install it
fnta JetBrainsMono.zip

# Update your terminal font settings to use the new font
# The font is now available in your system!
```

## Tips

- The name **fnta** is easy to remember (like "Fanta" the drink! 🥤)
- You can install fonts from anywhere - no need to navigate to the script location
- Multiple files are processed efficiently in one command
- The script skips invalid files and continues processing the rest

## License

Free to use and modify for personal or commercial use.

---

Made with ❤️ for easy font management on Linux
