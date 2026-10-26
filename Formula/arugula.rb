# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.2/arugula-0.63.2-x86_64-apple-darwin.tar.gz"
      sha256 "367e09c9bd11115ade6548e09feca3570b8968e6b855d2ddfbb9fee369a92cfb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.2/arugula-0.63.2-aarch64-apple-darwin.tar.gz"
      sha256 "6761b46339d59d8241ea5b2b672e5bf7aa8930627aa8f41a444463f6da234724"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.2/arugula-0.63.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c772ae3259cba8b4a801e125addffdec7ceed3300ca4ea601206b80eeafc0247"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.2/arugula-0.63.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "587f1a96dca0aed6b7c3b0cd88613163bb5cbcd0d9a7285786502f3011bea287"
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
