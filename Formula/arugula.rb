# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.91"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.91/arugula-0.70.91-x86_64-apple-darwin.tar.gz"
      sha256 "cc5f77170b3855ae6050f11d14800ab43da7061a088860a2ff3a8e74b173c4bd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.91/arugula-0.70.91-aarch64-apple-darwin.tar.gz"
      sha256 "b4cca0c2f265f0b863dfb2694a3e6ba90eb2b05021647065234ddaac376a8758"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.91/arugula-0.70.91-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0421ef61e0b80e8071dd7dd3cfb3c11c911cc1c5b5ab300964603c1294b0b498"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.91/arugula-0.70.91-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8c8b128def6f4effd3d7a0a5315f654f035278607a3689faa3d3eb46ba0c08aa"
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
