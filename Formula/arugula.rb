# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.87"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.87/arugula-0.70.87-x86_64-apple-darwin.tar.gz"
      sha256 "dbf0d110d90374a45fc19265b99ae30c371d174abf58a675b303f9751984f583"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.87/arugula-0.70.87-aarch64-apple-darwin.tar.gz"
      sha256 "41c587fce8afa23d4a4e6ed523258504f8e0c189c3e64fd04864349675950527"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.87/arugula-0.70.87-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fa9afc38393ee9c8dd3bd2fcd5100ca90d5a67799aba8b39110b794f93852f10"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.87/arugula-0.70.87-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fbf834de62a56cb4b8374dd952fea8990289c74069f628f86dda5fee98ad058e"
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
