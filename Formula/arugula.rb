# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.53.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.1/arugula-0.53.1-x86_64-apple-darwin.tar.gz"
      sha256 "49a7aebfe536dddf2662438d28a7dbcd0a171653688675db7d23fa01e6834049"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.1/arugula-0.53.1-aarch64-apple-darwin.tar.gz"
      sha256 "7913af49ad95f09f10d64ccdccd2c81dbac3cbfc742e9c3477e8cef1f9d25fdb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.1/arugula-0.53.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "90c9cf53616a2bc7e0afdf31e919700dac7ca66ebbbf1c455931a17f9d6c6d41"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.53.1/arugula-0.53.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a414b1e2313acf54422b134397c6d41668def924e790f1cf959136cf81b1d77b"
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
