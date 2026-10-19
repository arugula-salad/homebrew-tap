# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.46.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.5/arugula-0.46.5-x86_64-apple-darwin.tar.gz"
      sha256 "dbb6e9c92ff353a11b224286dc108298b9d3884d0ba71cd294c4a7061ce072f4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.5/arugula-0.46.5-aarch64-apple-darwin.tar.gz"
      sha256 "e731b68216a12429153adfb07d5727c43517725730d5f2b2f9e470b24a390e24"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.5/arugula-0.46.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e82c6cc4adab42446a2d0f806f4be3844758a6118f97fcb9b182818cfd65af71"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.5/arugula-0.46.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0f0b79114c2b5d13788d86f74cb28f09b44cf6a70a6a165cc259d3c8d92078ce"
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
