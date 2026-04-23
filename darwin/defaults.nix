{ config, lib, pkgs, ... }:

{
  # System documentation (disabled for performance)
  documentation.enable = false;
  documentation.doc.enable = false;

  # Global macOS system preferences
  system.defaults.NSGlobalDomain = {
    # Interface and appearance
    AppleInterfaceStyle = "Dark";  # dark mode
    AppleInterfaceStyleSwitchesAutomatically = false; # disable automatic switching for consistency
    
    # Localization
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    AppleTemperatureUnit = "Celsius";
    
    # Input preferences
    "com.apple.trackpad.scaling" = 3.0;
    InitialKeyRepeat = 10;
    KeyRepeat = 1;
    
    # Text input improvements
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    
    # Interface behavior
    AppleShowScrollBars = "Automatic";
    _HIHideMenuBar = true;
    
    # Print dialog defaults
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;
  };

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false; # Manual control over updates
  
  # Firewall configuration
  networking.applicationFirewall = {
    enable = true;
    allowSigned = true;
    allowSignedApp = true;
    enableStealthMode = true;
  };

  # Dock and Mission Control
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.0; # Remove delay for dock hiding
    autohide-time-modifier = 0.2; # Speed up dock animation
    show-recents = false;  # disable recent apps
    expose-group-apps = false;
    mru-spaces = false;
    tilesize = 40;
    minimize-to-application = true; # Minimize windows into app icon
    show-process-indicators = true; # Show indicator lights for open apps
    
    # Disable all hot corners for security
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  # Enhanced login and security settings
  system.defaults.loginwindow = {
    GuestEnabled = false;
    DisableConsoleAccess = true;
    SHOWFULLNAME = false; # Show username field instead of list
    LoginwindowText = "Pritam's MacBook Pro"; # Custom login message
  };
  
  # Additional security settings
  system.defaults.screensaver = {
    askForPassword = true;
    askForPasswordDelay = 0; # Require password immediately
  };

  # Spaces
  system.defaults.spaces.spans-displays = false;

  # Trackpad
  system.defaults.trackpad = {
    Clicking = true; # enable tap to click
    TrackpadRightClick = true;
  };

  # Enhanced Finder configuration
  system.defaults.finder = {
    AppleShowAllExtensions = true; # Show all file extensions
    FXEnableExtensionChangeWarning = false;  # disable warning when changing file extension
    ShowPathbar = true;  # show path bar
    ShowStatusBar = true;  # show status bar
    FXDefaultSearchScope = "SCcf"; # search current folder by default
    FXPreferredViewStyle = "clmv"; # display files/folders in column view
    NewWindowTarget = "Home"; # New Finder windows open to home folder
    QuitMenuItem = true; # Allow quitting Finder
    _FXShowPosixPathInTitle = true; # Show full POSIX path in title bar
    _FXSortFoldersFirst = true; # Sort folders before files
    AppleShowAllFiles = true; # Show hidden files (can be toggled with Cmd+Shift+.)
  };
  
  # Additional system preferences
  system.defaults.universalaccess = {
    reduceTransparency = false; # Keep transparency effects
    reduceMotion = false; # Keep animations
  };
}
