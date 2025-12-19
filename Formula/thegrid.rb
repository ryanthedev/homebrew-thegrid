class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.1.1/thegrid-0.1.1-darwin-universal.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  version "0.1.1"

  depends_on :macos => :ventura

  def install
    # Install pre-built universal binaries
    bin.install "bin/grid-server"
    bin.install "bin/thegrid"
  end

  def caveats
    <<~EOS
      To start the grid server as a service:
        brew services start thegrid

      Or run manually:
        grid-server

      Prerequisites:
        - Accessibility permissions required (System Settings > Privacy)
        - SIP must be partially disabled for full functionality

      Documentation: https://github.com/ryanthedev/the-grid
    EOS
  end

  service do
    run [opt_bin/"grid-server"]
    keep_alive true
    log_path var/"log/thegrid.log"
    error_log_path var/"log/thegrid.log"
  end

  test do
    assert_match "thegrid", shell_output("#{bin}/thegrid --help")
  end
end
