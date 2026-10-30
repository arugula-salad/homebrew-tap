# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.1/arugula-0.66.1-x86_64-apple-darwin.tar.gz"
      sha256 "76108850092de97f286fb752bd60a7869199fbcb9860e263c58bffe540f9852a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.1/arugula-0.66.1-aarch64-apple-darwin.tar.gz"
      sha256 "d9c9e440d7c889316c0c0e00976e2d219a5e7a183627252c93147a63ddfa98b1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.1/arugula-0.66.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "faa22bf4ab2b03b1745fc15479df093ba222e5366e2fb281bc73ab19decb95f3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.1/arugula-0.66.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9d73c675c0a99d3e159b0b6bca76e5f094f65537bee2859510cbed6d8f090d67"
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
