# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.112"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.112/arugula-0.70.112-x86_64-apple-darwin.tar.gz"
      sha256 "7146871a3e45890459d4158ec412ed5c3cd8a030309bbc8031643f540f4eeddd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.112/arugula-0.70.112-aarch64-apple-darwin.tar.gz"
      sha256 "1f572b8ab5f6d067966dc7c248e94bd1a8be02d0d27baaa244b816d6398fafea"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.112/arugula-0.70.112-x86_64-unknown-linux-musl.tar.gz"
      sha256 "98f9451fb1b15e978545f46b9b3ca1f17b541e260680ce6ee8b432b671c46c22"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.112/arugula-0.70.112-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d8c8d26205e2f22a04e41e9c3f566f1933e414246551a3794e0a0d644063630f"
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
