# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.24"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.24/arugula-0.70.24-x86_64-apple-darwin.tar.gz"
      sha256 "c93ff13a6a6ad3ec64447cd343fca137a5336a89e1d64d160df9ff9003e28df7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.24/arugula-0.70.24-aarch64-apple-darwin.tar.gz"
      sha256 "f1f6df5aa628e88dc4e9d0327fa1907edc849f4b226bcab161e8e77c87c2decf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.24/arugula-0.70.24-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ff5fbf7a9bcc20104042e90a1f88b09929e6ef6c95d25a0a9bf17214b44b7628"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.24/arugula-0.70.24-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fc22849c4805b18433476bd4b1ca19924ae15d444d431118163221901806e69f"
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
