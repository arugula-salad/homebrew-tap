# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.44.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.44.0/arugula-0.44.0-x86_64-apple-darwin.tar.gz"
      sha256 "c1b8e6a87c29687151db6908e9ab930e0ac9f55a4820e40063815babf9ce899e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.44.0/arugula-0.44.0-aarch64-apple-darwin.tar.gz"
      sha256 "94dac882486b902690d033acc0bb61584a6d0ba9d0bed7a1ead5f75aaec579ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.44.0/arugula-0.44.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d2d8bc7b5556c4f77c5ccb2163903afc2fed7713772f7b5788284d49f744a091"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.44.0/arugula-0.44.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2bdcdbd092b109af0a5799690563627794136c1ffc543f0a6a6c6c8f63d6e407"
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
