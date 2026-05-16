class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.5.5/thegrid-0.5.5-darwin-universal.tar.gz"
  sha256 "419492fcdf2c17f6cd46655ff97f24182ee09d87122f73db9930393c9134b224"
  license "MIT"
  version "0.5.5"

  depends_on :macos => :ventura

  def install
    prefix.install "GridServer.app"
    prefix.install "GridNotify.app"
    bin.install "bin/thegrid"
    bin.install "bin/grid-viewer"
    bin.install_symlink prefix/"GridServer.app/Contents/MacOS/grid-server"
    bin.install_symlink prefix/"GridNotify.app/Contents/MacOS/grid-notify"
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
