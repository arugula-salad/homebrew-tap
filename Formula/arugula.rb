# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.65.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.3/arugula-0.65.3-x86_64-apple-darwin.tar.gz"
      sha256 "f3d351ff9b4135b40d96fdb218c77c4a86d65a8333e28d1fcfe2389931f836f9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.3/arugula-0.65.3-aarch64-apple-darwin.tar.gz"
      sha256 "6de42a7cff1066058f7a657117ba632442e0c05fcc5c45cc53616e8b8ab01368"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.3/arugula-0.65.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "11ceef424023fffe65996e0c60af85af87f9a732c14e58af4cbe37b016b466b0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.3/arugula-0.65.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "90dbf4c5008c798e9bb5abca8fe909dd4dbeb962164fa1467b84707edb640bdf"
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
