# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.129"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.129/arugula-0.70.129-x86_64-apple-darwin.tar.gz"
      sha256 "569881b0f94f8a2d088b9ece02da0af033fcc25dd109c36e9e29090fbf60d530"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.129/arugula-0.70.129-aarch64-apple-darwin.tar.gz"
      sha256 "6423886292a138faf9675b367ebbf341375d83eeedf49142c0cb6e15f921ce41"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.129/arugula-0.70.129-x86_64-unknown-linux-musl.tar.gz"
      sha256 "79fe7a0fc682499223df3340f1d22e41ebb432d24f3479a9e281a0b106028b70"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.129/arugula-0.70.129-aarch64-unknown-linux-musl.tar.gz"
      sha256 "95988ae2506ab2ba6dbf3eb04d2b47db1be5290b4ad769c1cb42c2b32b3f016d"
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
