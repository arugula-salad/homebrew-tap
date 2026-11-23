# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.93"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.93/arugula-0.70.93-x86_64-apple-darwin.tar.gz"
      sha256 "acc684d0a95fca567b2d62c49634b481a30d6a91437401de3690cce5b48e922f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.93/arugula-0.70.93-aarch64-apple-darwin.tar.gz"
      sha256 "5436c0eb6ebeea0b8cb6282535cc052615dc5c42a27f0c9ff6fb2cd7790b3d46"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.93/arugula-0.70.93-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6a8b091c8ea84b21dc6f8b2fda6da3835619174539fbf8dd96ecaca62ff20f5b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.93/arugula-0.70.93-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4fbcd151c7faa20ad7db80f3871807befabb85ab0b293891e21398bc9ae74e6f"
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
