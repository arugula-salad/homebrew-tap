# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.57.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.0/arugula-0.57.0-x86_64-apple-darwin.tar.gz"
      sha256 "fce8c95f10bdbcca72f3bfcfb4490f00235fc9511eb36b4714fe11dbc3c5e154"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.0/arugula-0.57.0-aarch64-apple-darwin.tar.gz"
      sha256 "22f18ec61f1929b70137dae493e3f67cde92e9d284cd59d2f9df7e873adfff21"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.0/arugula-0.57.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2813c9cc1cbe47fd72c1fe51f789d97a15834a01aa4af778216e49c9e412d207"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.0/arugula-0.57.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "47327d9b659f762c75d7a4a354b506e05e96c7bc470792412dbfee3863ce4baf"
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
