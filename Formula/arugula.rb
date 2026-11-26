# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.124"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.124/arugula-0.70.124-x86_64-apple-darwin.tar.gz"
      sha256 "f3c90b76c2576a7de0fee97c98c58ad9f04f8192372b4a31736f42850c06b700"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.124/arugula-0.70.124-aarch64-apple-darwin.tar.gz"
      sha256 "ec6cb831d27b487d4f34653966e31ccb115a01614c071033252fd5c5c0c9f386"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.124/arugula-0.70.124-x86_64-unknown-linux-musl.tar.gz"
      sha256 "53fc3f3a366b749f561ac0ee1f1834227c3e394f061da010ea523cc799382493"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.124/arugula-0.70.124-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4d6e327f980f9b3b14bb086ae84d36b85f34472f6ac3573d1c8ffa624f2a5bd0"
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
