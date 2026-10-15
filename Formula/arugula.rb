# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.39.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.3/arugula-0.39.3-x86_64-apple-darwin.tar.gz"
      sha256 "820998979effc6b19d71cc890f739b56c6dd1e8372be8bb9c620fb4501a17304"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.3/arugula-0.39.3-aarch64-apple-darwin.tar.gz"
      sha256 "24476637a5ddc5d2c4f1501ed3fbc08ee8aa3c215cd51009abff3d9ae1edaa4c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.3/arugula-0.39.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80c689ac81c7ff952043095edf6187d307c3398693a8dd52fe05587fd48dc3b0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.3/arugula-0.39.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "acbdef673de8b4b813fd65addbe10c633f7d5b8b06dc40329f79429f3f0c58f1"
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
