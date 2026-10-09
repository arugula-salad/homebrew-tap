# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.30.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.2/arugula-0.30.2-x86_64-apple-darwin.tar.gz"
      sha256 "bbb12a8039596aab33c7b3da77b7592d7173995e488560e6801741944824befd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.2/arugula-0.30.2-aarch64-apple-darwin.tar.gz"
      sha256 "3d84380266f9762c4da03c543fcef81b2ab50fa32d7389a1705064329fc12fda"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.2/arugula-0.30.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "612467ccd56d9cb11bb3d58d13a84c966e103f1ddffb992e7d155053b3a83c75"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.2/arugula-0.30.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "62c025e8bce7012bcc83babd894bc55ed9266c2fb815494903024ad246d129c7"
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
