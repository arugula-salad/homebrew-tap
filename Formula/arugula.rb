# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.35.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.35.0/arugula-0.35.0-x86_64-apple-darwin.tar.gz"
      sha256 "c87c12739279063bd7374f36d58f5c8d88f229840eaa6cd1d4adfeb5aca961d8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.35.0/arugula-0.35.0-aarch64-apple-darwin.tar.gz"
      sha256 "6a96fb57f75f06798fccd9dd0889e1c27a5bf46f6a6a959236ba5229844b3b1d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.35.0/arugula-0.35.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a488f6e9ffd78e708057c8a013d29ff21dc1912c7a7b073e6e5180b1f88fb5b5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.35.0/arugula-0.35.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3595a21cf8dcd5ea51d9ecc1c05861ed7832c088808db81c284f0ddc4f66094f"
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
