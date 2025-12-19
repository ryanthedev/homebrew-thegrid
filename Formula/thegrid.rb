class Thegrid < Formula
  desc "Window management system for macOS"
  homepage "https://github.com/ryanthedev/thegrid"
  url "https://github.com/ryanthedev/the-grid/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "cb9e54af319f1f13771920b9bc6b37e3f255d1e97753d359fcbd6517db3d9d49"
  license "MIT"
  version "0.1.1"

  depends_on :macos => :ventura
  depends_on :xcode => ["14.0", :build]
  depends_on "go" => :build

  def install
    # Build server (Swift)
    system "swift", "build", "-c", "release",
           "--package-path", "grid-server"

    # Build CLI (Go)
    cd "grid-cli" do
      system "go", "build", "-o", "#{bin}/thegrid", "./cmd/grid"
    end

    # Install binaries
    bin.install "grid-server/.build/release/grid-server"
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

      Documentation: https://github.com/ryanthedev/thegrid
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
