# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.43.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.43.0/arugula-0.43.0-x86_64-apple-darwin.tar.gz"
      sha256 "39402e9f0a0e6a2add427bbb322c5cafe737790870be6bd4249e942241f1566e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.43.0/arugula-0.43.0-aarch64-apple-darwin.tar.gz"
      sha256 "5f31944ed07840ce4b4c7d476c1e4b8b72c674d09ee26063750a46330b574781"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.43.0/arugula-0.43.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cfb41adacb8a01aedb894b135108011ff324a20bdab409147de18d1484cff3e5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.43.0/arugula-0.43.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f60888bfea9a953928addc22b1929a6bb8c67af61849a54ff84caeb8efad35b7"
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
