# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.132"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.132/arugula-0.70.132-x86_64-apple-darwin.tar.gz"
      sha256 "f20fed54d9a64cd19c1f308e0df94d3e925016abacf8b979574de2e52fbb76da"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.132/arugula-0.70.132-aarch64-apple-darwin.tar.gz"
      sha256 "6ddff435c5a90a16a06bbd9df9a2a1aebd28d8bd913a5245eb80dcd55c4d19cc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.132/arugula-0.70.132-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8a0792f4b000e3625d3423efc520022ccebdd902c0186dc2aaa73afd19f22cff"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.132/arugula-0.70.132-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6f1d0ec0d714534a776666388bc06aa3679bacaddd81935611558b3bde69ec8c"
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
