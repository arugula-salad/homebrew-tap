# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.4/arugula-0.63.4-x86_64-apple-darwin.tar.gz"
      sha256 "66bbbddcf936c2e9234f1f9231edf1106ccacab708a25d60783c7f1ad1e7bec9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.4/arugula-0.63.4-aarch64-apple-darwin.tar.gz"
      sha256 "e3226c559a677e06424fe7dd5278ea26af96c9f620406fc171cd52fd6f691706"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.4/arugula-0.63.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e14ad27a443b084682c34948e57086ffff9e1566263f82b81b36cc6a9c483042"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.4/arugula-0.63.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2d26ea5d0fa49e1572a5d6343c122c4a26621cd2cdde79bfd1bb1a852065bfc4"
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
