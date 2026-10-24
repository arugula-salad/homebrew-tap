# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.15/arugula-0.60.15-x86_64-apple-darwin.tar.gz"
      sha256 "3fc27ac10d1f4a6d60acc66a2cc84b19be98e31ad7d49c86ad061a0709228820"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.15/arugula-0.60.15-aarch64-apple-darwin.tar.gz"
      sha256 "bae734780255bde7d7044f642d618df4bd2932bfdd01343d1320129bf92dfc77"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.15/arugula-0.60.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a2c8872f243d984d5ababdbffdbdeb40f353335bc72a6f68b55bf8394b13f733"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.15/arugula-0.60.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9efd5377f2793aec4f1106a593ce1a11284a6d248e4185e3b30afe90cf2606a0"
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
