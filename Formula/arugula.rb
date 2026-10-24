# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.14/arugula-0.60.14-x86_64-apple-darwin.tar.gz"
      sha256 "2267b797e3a20dfe2c5ac3c831f06807b87c54dbfd8acfd6a1958d7b2f7fdb9a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.14/arugula-0.60.14-aarch64-apple-darwin.tar.gz"
      sha256 "390212d7af4e8600fee610e45d4d7f236695245990775a36c63319c05085b643"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.14/arugula-0.60.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cb1589f2d61f73a0098ab7aaa3993fe59ec36b765122fb770708553a101a8bb7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.14/arugula-0.60.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dd78b679c0430cbe3d5a554d3a1c184f6195d917570c88e20085330796ed3bfe"
    end
  end

  def install
    bin.install "arugulad", "arugula"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        arugulad install
      It copies itself to ~/.local/bin, runs from there, and prints the
      next steps: where to open it, its logs, your phone (Tailscale) and
      Arugula control. Then, for Claude Code:
        claude mcp add arugula -- arugula mcp
      Docs: https://arugula.io/#install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arugulad --version")
  end
end
