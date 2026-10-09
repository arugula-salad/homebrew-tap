# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.31.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.0/arugula-0.31.0-x86_64-apple-darwin.tar.gz"
      sha256 "ae06e8bc3270a2665a756007be1bc84cefa97e325bed7cf84a59a49041cc5e50"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.0/arugula-0.31.0-aarch64-apple-darwin.tar.gz"
      sha256 "5bfd94556b211914511a3bb6db1f0c37c3bc8b1af08c430538ab8966c4c65851"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.0/arugula-0.31.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "520b4693dd65d8f9380a895ce6099e12eb40b0e672a6c612073f11a2b38fb753"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.31.0/arugula-0.31.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dae270ed5ce2b66a672f24c31a204fa8f05b0771c352e5c32b81791516936c94"
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
