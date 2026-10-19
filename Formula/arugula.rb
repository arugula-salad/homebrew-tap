# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.48.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.48.0/arugula-0.48.0-x86_64-apple-darwin.tar.gz"
      sha256 "ebdd82c0225c89862723ea2646837aefb2b5c3fffcfa722592c3ec5cf082ed4f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.48.0/arugula-0.48.0-aarch64-apple-darwin.tar.gz"
      sha256 "d1f285bcd1a8dac24fe0b455d1da854717d95c9663c6611621d1924a6af45df1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.48.0/arugula-0.48.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8723cc35aca057fb78516450c5ae86f57302e0f846ace9ed9de7c80e1ae6710f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.48.0/arugula-0.48.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1e7ddee8c260f9487abb51b07e0c97ea143010dc979cdda66dfdd2f5281ca052"
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
