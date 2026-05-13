{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time / Locale
  time.timeZone = "Africa/Nairobi";
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us";

  # Printing + Audio
  services.printing.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # === Nix Settings (Very Important) ===
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "njue" ];

  # === Programs ===
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Modern terminal experience
  programs.zsh.enable = true;
  programs.starship.enable = true;

  # Vim with full features
  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.vim-full.override {
      python3 = pkgs.python3;
    };
  };

  # VS Code (highly recommended for Data Science)
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-toolsai.jupyter
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      mhutchie.git-graph
      eamodio.gitlens
      charliermarsh.ruff
      yzhang.markdown-all-in-one
    ];
  };

  # Allow unfree packages (VS Code, etc.)
  nixpkgs.config.allowUnfree = true;

  # === User ===
  users.users.njue = {
    isNormalUser = true;
    description = "njue";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
    shell = pkgs.zsh;
  };

  # === System Packages (Data Science & Dev focused) ===
  environment.systemPackages = with pkgs; [
    #bitwarden 
    bitwarden-desktop
    # Core
    git git-lfs
    xclip wl-clipboard
    curl wget
    ripgrep fd fzf bat eza
    tree htop btop
    tmux lazygit gh    # GitHub CLI + lazygit
    jq yq unzip zip
    ncdu duf

    # Build tools
    gnumake cmake gcc clang llvm
    pkg-config openssl zlib

    # C / C++ development
    gdb valgrind lldb
    bear   # for generating compile_commands.json

    # Python Data Science
    (python3.withPackages (ps: with ps; [
      pip setuptools wheel virtualenv
      numpy pandas scipy matplotlib seaborn
      scikit-learn statsmodels plotly sympy
      jupyterlab notebook ipykernel
      polars pyarrow requests tqdm
      black ruff isort mypy
    ]))

    # Docker
    docker docker-compose

    # Other useful tools
    sqlite postgresql
    nodejs
    poetry          # Alternative Python dependency manager
    uv              # Fast Python package manager (recommended)
  ];

  # Docker
  virtualisation.docker.enable = true;

  # Keep this at the version you installed with
  system.stateVersion = "25.11";
}