class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.3.0/thegrid-0.3.0-darwin-universal.tar.gz"
  sha256 "920bec98a7043c842ee4d8472e77cc64cf6e174efbe639e384f33643f441fc54"
  license "MIT"
  version "0.3.0"

  depends_on :macos => :ventura

  def install
    # Install the app bundle (required for Accessibility permissions)
    prefix.install "GridServer.app"

    # Install CLI, picker, and terminal binaries
    bin.install "bin/thegrid"
    bin.install "bin/grid-picker"
    bin.install "bin/grid-terminal"

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
