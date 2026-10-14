# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.39.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.0/arugula-0.39.0-x86_64-apple-darwin.tar.gz"
      sha256 "d2739f676878abd306cbb6c7d0206596c458a6165a3c64ddb513b5fb45085f7a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.0/arugula-0.39.0-aarch64-apple-darwin.tar.gz"
      sha256 "ed1ec1179081922f9980eff8d8cbef744cd916861ba646f0b57e81ab4494f9eb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.0/arugula-0.39.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4940d894d2fd19bd496be205f6ae26bd2b365340abd3d6f9e4848b5c4dc5d6c7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.39.0/arugula-0.39.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "21719631e961b3bcf7facdf36d1ade1d478e2fc8ba931a6bd6635308531651e0"
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
