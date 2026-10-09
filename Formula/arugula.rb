# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.30.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.0/arugula-0.30.0-x86_64-apple-darwin.tar.gz"
      sha256 "6da25e108f460fc96ae10acc06a33e6b9e3ea94756ac3c8d44c9503d9d6919f3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.0/arugula-0.30.0-aarch64-apple-darwin.tar.gz"
      sha256 "c02976725c04fa0d016bcdeaebfbd996f1ce8d8d62845ec600cd85bbec6b322c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.0/arugula-0.30.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f9e625c739d7b5ecc29461f3fd111e8b0a6da449bc07966d36d4fc084eedfbd8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.0/arugula-0.30.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0e0f56b3a669ebca7915e02e7c1e0440fe7ae3e4585ea6e536fcb504b39384ac"
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
