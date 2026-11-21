# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.78"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.78/arugula-0.70.78-x86_64-apple-darwin.tar.gz"
      sha256 "d08a7cc0483340421b5b54aa1ccd5eb1d8e9e16ae8fde01cfc383e4f70ea40a9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.78/arugula-0.70.78-aarch64-apple-darwin.tar.gz"
      sha256 "6e1518e26f6ba68fde55a7fb618437c5dbc494a785545bc8fb9fa6e7f4813531"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.78/arugula-0.70.78-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5fa0ce9c2948b09d89d748ce34fca6a4324e7cc5af15ea2da21cdab6f906b27a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.78/arugula-0.70.78-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6e7f3d5b8a0ef09b2c73ffeabe113d09e7b269c7201a656ef0e6fbeb68136b6d"
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
