# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.26"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.26/arugula-0.70.26-x86_64-apple-darwin.tar.gz"
      sha256 "898fa50233d344e801f6f3a123b8f801c2bda03432f2370873ba96cdfedf9069"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.26/arugula-0.70.26-aarch64-apple-darwin.tar.gz"
      sha256 "3b3f1aae5c2526b27b516f3e9082bca0860fdd3196731a920ff23b3efea5ae61"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.26/arugula-0.70.26-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80b03277af30abd549c9c6c3bc88142d95a60aabc517fa88e9f8e9127b60e2a9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.26/arugula-0.70.26-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0ebf0434e615842ffe2db04f653ee061e673dfd741cef2fdee570ec67ed7edc7"
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
