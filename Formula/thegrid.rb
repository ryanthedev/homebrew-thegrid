class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.1.2/thegrid-0.1.2-darwin-universal.tar.gz"
  sha256 "1a0cb83214f86721e00e413048c0e6940cb4ed0548e3907f5654c583ea28c8ea"
  license "MIT"
  version "0.1.2"

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
