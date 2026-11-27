# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.140"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.140/arugula-0.70.140-x86_64-apple-darwin.tar.gz"
      sha256 "322abb2a1136f0f1bb5cf0d58f473a6cbdc5c87ecd0b52522a1e5eee28495724"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.140/arugula-0.70.140-aarch64-apple-darwin.tar.gz"
      sha256 "fd5a4a62d4ff907b266e68b888c604ba7b7d4f281232cc05ac6e62e99d5a2594"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.140/arugula-0.70.140-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0508643395c3681bbc8795798f01d478ad27708372440ff1b874c5a9516aa7a5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.140/arugula-0.70.140-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fd79f7a833373a2a07372b8b4400c4beb570c910af68d1c056441a930a7878fa"
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
