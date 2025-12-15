# Homebrew Tap for theGrid

This is the Homebrew tap for [theGrid](https://github.com/ryanthedev/thegrid), a powerful window management system for macOS.

## Installation

```bash
brew tap ryanthedev/thegrid
brew install thegrid
```

## Usage

After installation, start the grid server as a service:

```bash
brew services start thegrid
```

Or run manually:

```bash
grid-server &
```

Then use the CLI:

```bash
thegrid list windows            # List all windows
thegrid layout apply ide        # Apply a layout
thegrid focus right             # Move focus to adjacent cell
```

## Requirements

- macOS 13.0 (Ventura) or later
- Accessibility permissions (System Settings > Privacy & Security > Accessibility)
- SIP must be partially disabled for full functionality

## Documentation

See the main repository for full documentation: https://github.com/ryanthedev/thegrid
