class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/the-grid"
  url "https://github.com/ryanthedev/the-grid/releases/download/v0.4.3/thegrid-0.4.3-darwin-universal.tar.gz"
  sha256 "926e42798c232f93445284029cf85e08df57d2ae4e5ece118da41dcdd12827d3"
  license "MIT"
  version "0.4.3"

  depends_on :macos => :ventura

  def install
    prefix.install "GridServer.app"
    bin.install "bin/thegrid"
    bin.install "bin/grid-viewer"
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
