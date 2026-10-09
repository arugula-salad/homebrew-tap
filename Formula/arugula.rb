# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.30.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.1/arugula-0.30.1-x86_64-apple-darwin.tar.gz"
      sha256 "6764d0a08ca5802ad688d6618bec75f0fd1faf6bdf691c411fe801b165d3db83"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.1/arugula-0.30.1-aarch64-apple-darwin.tar.gz"
      sha256 "f81093ac3ce75d9777b0156197138b7f35f765599279d24d44e1c0b31c3ae9c8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.1/arugula-0.30.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9e00e0eac1c71fc30ed825fbe37362c09fbb3fb472a167361979704118dedc39"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.30.1/arugula-0.30.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1aa7d82eef7fc557cbf589dadfa7449589f84644dc0f6db0b5b5bdc6bcda7782"
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
