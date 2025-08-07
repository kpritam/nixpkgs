# Pritam's Nix-Darwin Configuration

A modern, declarative macOS system configuration using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager).

## 🚀 Quick Start

### Prerequisites
1. Install Nix with flakes support:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. Clone and apply this configuration:
   ```bash
   git clone <your-repo-url> ~/.config/nixpkgs
   cd ~/.config/nixpkgs
   nix flake update
   darwin-rebuild switch --flake .#MacBookPro
   ```

## ✨ What's Included

### 🔒 Security & Privacy
- TouchID authentication for sudo
- Application firewall enabled with stealth mode
- Secure system defaults
- Privacy-focused DNS (Cloudflare + Google)

### 💻 Development Environment
- **Editors**: VS Code Insiders, Zed Preview, Neovim, Emacs
- **Version Control**: Git with delta diffs, GitHub CLI
- **Languages**: Go, Node.js, Rust, Python (uv), Lua
- **Tools**: Docker alternatives (OrbStack, Colima), Kubernetes tools, AWS CLI

### 🎨 UI/UX Enhancements  
- **Window Management**: Yabai + skhd for tiling
- **Productivity**: Raycast, Hammerspoon automation
- **Fonts**: Nerd Fonts collection for programming
- **Terminal**: Modern shell tools (bat, eza, fd, ripgrep, zoxide)

### 📦 Package Management
- **Nix**: Reproducible system and user packages
- **Homebrew**: GUI applications and tools not in nixpkgs
- **Home Manager**: Declarative user environment

## 🏗 Architecture

This configuration follows modern Nix best practices:

### Flake-based Configuration
- All dependencies managed through [`flake.nix`](./flake.nix)
- Pinned inputs for reproducibility
- Support for both stable and unstable nixpkgs

### Modular Structure
- **System Level**: [`darwin/`](./darwin/) - macOS system configuration
- **User Level**: [`home/`](./home/) - User-specific settings via Home Manager  
- **Libraries**: [`lib/`](./lib/) - Reusable helper functions
- **Custom Modules**: [`modules/`](./modules/) - Extended functionality

### Key Features
- **Legacy Compatibility**: [`default.nix`](./default.nix) via flake-compat
- **Optimized Performance**: Binary caches, auto-optimization enabled
- **Apple Silicon Support**: Native aarch64-darwin configuration
- **Secure Defaults**: Hardened system preferences

## 🛠 Usage

### Daily Commands
```bash
# Rebuild system configuration
darwin-rebuild switch --flake .

# Update all dependencies
nix flake update

# Check configuration before building
nix flake check

# Build without switching (for testing)
darwin-rebuild build --flake .
```

### Maintenance
```bash
# Clean up old generations
darwin-rebuild --list-generations
nix-collect-garbage -d

# Optimize Nix store
nix store optimise

# Update specific input
nix flake lock --update-input nixpkgs-unstable
```

## 📝 Customization

### Personal Information
Update user details in [`flake.nix`](./flake.nix):
```nix
primaryUserDefaults = {
  username = "pritamkadam";
  fullName = "Pritam Kadam";
  email = "phkadam2008@gmail.com";
  nixConfigDirectory = "~/.config/nixpkgs";
};
```

### Adding Packages
- **Nix packages**: Add to [`home/packages.nix`](./home/packages.nix)
- **Homebrew casks**: Add to [`darwin/homebrew.nix`](./darwin/homebrew.nix)
- **System tools**: Add to [`home/packages.nix`](./home/packages.nix) or homebrew

### System Preferences
Modify [`darwin/defaults.nix`](./darwin/defaults.nix) for:
- macOS system defaults
- Security settings
- UI preferences

## 🔍 File Structure

```
.
├── flake.nix              # Main flake configuration
├── flake.lock            # Dependency lock file
├── default.nix           # Legacy compatibility
├── darwin/               # macOS system configuration
│   ├── defaults.nix      # System defaults & security
│   ├── general.nix       # General system settings  
│   ├── homebrew.nix      # Homebrew packages
│   └── bootstrap.nix     # Minimal bootstrap config
├── home/                 # Home Manager configuration
│   ├── packages.nix      # User packages & programs
│   ├── git.nix          # Git configuration
│   ├── fish.nix         # Fish shell setup
│   └── *.nix            # Other configurations
├── lib/                  # Reusable functions
│   └── mkDarwinSystem.nix # Darwin system builder
└── modules/              # Custom modules
    └── darwin/
        └── users.nix     # User management
```

## 🚀 Getting Started

1. **Fork this repository** and customize the personal information
2. **Review packages** in homebrew.nix and packages.nix  
3. **Adjust system defaults** in darwin/defaults.nix to your preferences
4. **Test the configuration** with `darwin-rebuild build --flake .`
5. **Apply changes** with `darwin-rebuild switch --flake .`

## 🐛 Troubleshooting

### Common Issues
- **Build failures**: Run `nix flake check` to validate syntax
- **Permission errors**: Ensure you're in the admin group
- **Homebrew conflicts**: Avoid duplicate packages between Nix and Homebrew

### Resources
- [Nix-Darwin Manual](https://nix-darwin.github.io/nix-darwin/manual/)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)
- [Nixpkgs Search](https://search.nixos.org/packages)

## 📄 License

This configuration is provided as-is for educational purposes. Feel free to use and modify.
