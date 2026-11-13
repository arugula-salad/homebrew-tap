# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.24"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.24/arugula-0.69.24-x86_64-apple-darwin.tar.gz"
      sha256 "2b11a3b143ef7f02f0161dff327fddb11cd80d2c20bc255db6b6f8ef97859ba3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.24/arugula-0.69.24-aarch64-apple-darwin.tar.gz"
      sha256 "5b3f986ac8c1b8230b72550dd2af47b1e8259cecdc8cc49de24189a695de961d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.24/arugula-0.69.24-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5d7e4e80c79f104a97ee1d9b5cbda9712491d34d0481ce08645989c1c75ba2bb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.24/arugula-0.69.24-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4ba4b3ed1619d50586848c21ae2e8c1610cbe67492bada75ad64f2c04d4d18de"
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
