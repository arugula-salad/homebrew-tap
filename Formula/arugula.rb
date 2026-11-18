# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.44"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.44/arugula-0.70.44-x86_64-apple-darwin.tar.gz"
      sha256 "f289e5a157568045b4bd533bf353fb926c51bbbb3a8793dfdb91956b46352dfd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.44/arugula-0.70.44-aarch64-apple-darwin.tar.gz"
      sha256 "e844553016dcc3cb193e5ebf3b0b53c9791a1b227d2e36e6dc3fa7f27c0c13aa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.44/arugula-0.70.44-x86_64-unknown-linux-musl.tar.gz"
      sha256 "53fa31810d8053cc686bf080284934b78e4c5f6c6b4150c9fbc1f36093c0d2e9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.44/arugula-0.70.44-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7f86ccb93733dc2cf791335f9e79836be51bb8c631317310b38f38c42a2bf3a2"
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
