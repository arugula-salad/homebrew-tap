# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.6/arugula-0.60.6-x86_64-apple-darwin.tar.gz"
      sha256 "0cd02839a8b4bb51285414aa18627696d36833d497f6d22b2c044ae361cd5f31"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.6/arugula-0.60.6-aarch64-apple-darwin.tar.gz"
      sha256 "cd733e2f85914ada77636c1d800bf335ee02fbfffd6ed40e630a8fc5c102c842"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.6/arugula-0.60.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "faf84f7fc9d953cac4a6a2398f792b5bb08e3bf173417c3c6d36537871c815d9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.6/arugula-0.60.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "055d1f789975d7b382583754720a6a81a4c06fc0023a117f004bf0146bb62279"
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
