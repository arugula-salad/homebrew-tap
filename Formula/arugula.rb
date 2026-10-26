# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.3/arugula-0.63.3-x86_64-apple-darwin.tar.gz"
      sha256 "9ab5c738006f6dc37706efdd9a797fcd41dfbbf2f90ab29b73574f87e9818ae0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.3/arugula-0.63.3-aarch64-apple-darwin.tar.gz"
      sha256 "f56e92283eb83cbe862000e4fc895433f3bf8718d73070803e710e337926f9c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.3/arugula-0.63.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cbce742c9046d557efe19eac41b8c4cc40947be609b16f5a937b899caaccc1d3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.3/arugula-0.63.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f97b4dc4a6a15333aa1158cd293b00d68a746c52670d733c10f3dcb640a183c9"
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
