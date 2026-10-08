class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.9.2/thegrid-0.9.2-darwin-universal.tar.gz"
  sha256 "61719b79aab4d36053b0844ea28d35e4ad88f43b4d9d1bcffac0fd5204b44601"
  license "MIT"
  version "0.9.2"

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
