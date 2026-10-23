# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.8/arugula-0.60.8-x86_64-apple-darwin.tar.gz"
      sha256 "096c30f045045fc723213340aa93b2435ce20da89c2f7225b29c4ffb97359363"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.8/arugula-0.60.8-aarch64-apple-darwin.tar.gz"
      sha256 "5c7b34e09f5a754cc396ff19ddb0e23226e9642363e92c05801f7ba2f22dbf71"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.8/arugula-0.60.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7a2a375306c565bc1f7c4f3c98940139808ef3252685163a0e45cef841a5335f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.8/arugula-0.60.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "70e7c99849178e194620015c480ea29caff2065b0d49e6ce895142d1f82bbe32"
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
