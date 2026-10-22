# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.0/arugula-0.60.0-x86_64-apple-darwin.tar.gz"
      sha256 "f97212962880380bf94ffc2c365bbf2da80dd9d2085375b8f03fde43b23a578b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.0/arugula-0.60.0-aarch64-apple-darwin.tar.gz"
      sha256 "2bb2c66b7f7aa16651f4f58e760ce29cd5ed1a475fa624be046be8af06afccd3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.0/arugula-0.60.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8721a5f3e297716ad21e9d04fb43d668862f244b59f3122e43ba971ad5a3c1d6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.0/arugula-0.60.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "77c8923ff483a3a520eeb7396e0aeb869691a0807d683cb0208aa5e680bd4732"
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
