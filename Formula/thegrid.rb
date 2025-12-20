class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.1.5/thegrid-0.1.5-darwin-universal.tar.gz"
  sha256 "c384043d52b13b3d4a554e558aee9a1bc0138a450d0b56a91bb7d0ac789593d0"
  license "MIT"
  version "0.1.5"

  depends_on :macos => :ventura

  def install
    # Install the app bundle (required for Accessibility permissions)
    prefix.install "GridServer.app"
    
    # Install CLI binary
    bin.install "bin/thegrid"
    
    # Create symlink for grid-server command
    bin.install_symlink prefix/"GridServer.app/Contents/MacOS/grid-server"
  end

  def caveats
    <<~EOS
      GridServer.app has been installed to:
        #{prefix}/GridServer.app

      To grant Accessibility permissions:
        1. Open System Settings > Privacy & Security > Accessibility
        2. Click + and add: #{prefix}/GridServer.app
        3. Toggle the switch to enable

      To start the grid server as a service:
        brew services start thegrid

      Or run manually:
        grid-server

      Documentation: https://github.com/ryanthedev/the-grid
    EOS
  end

  service do
    run [opt_prefix/"GridServer.app/Contents/MacOS/grid-server"]
    keep_alive true
    log_path var/"log/thegrid.log"
    error_log_path var/"log/thegrid.log"
  end

  test do
    assert_match "thegrid", shell_output("#{bin}/thegrid --help")
  end
end
