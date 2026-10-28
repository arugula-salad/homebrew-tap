# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.64.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.0/arugula-0.64.0-x86_64-apple-darwin.tar.gz"
      sha256 "e8b41a33be7f0376e1476e29ab55effd0d9bbf7bc58dc9173a37fecd44c73d21"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.0/arugula-0.64.0-aarch64-apple-darwin.tar.gz"
      sha256 "beb1f9ddbd70bb70fbe04e9a8d5057a237604cdd2e212031a2e3d51c89a38f17"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.0/arugula-0.64.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6d4790f2240bd74accd2aa1c197ba005b4250dacaf68a60fdc6e5b9d628a92f6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.64.0/arugula-0.64.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b5a28b5debb24127f174e151cf5da1a7e150ec382504a288d41478a166140707"
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
