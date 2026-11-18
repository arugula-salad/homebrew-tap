# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.40"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.40/arugula-0.70.40-x86_64-apple-darwin.tar.gz"
      sha256 "4d2dc6cd028890b6030621ac7684de58017032813377bc278557d942a4a6cf9e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.40/arugula-0.70.40-aarch64-apple-darwin.tar.gz"
      sha256 "915755ae83176868763df23e8971fae0ba81db07a6c942fda29a887a0e38dc52"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.40/arugula-0.70.40-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d65eb5b62f46254d24eccd2cc6f5e736fcc6dcb8f33e287052e391096339532"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.40/arugula-0.70.40-aarch64-unknown-linux-musl.tar.gz"
      sha256 "70d6c7702120f4ee79cb6e0e45ec65e91497ef78982c1bf8bb77516b57633fe3"
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
