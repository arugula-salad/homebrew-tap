# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.29"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.29/arugula-0.70.29-x86_64-apple-darwin.tar.gz"
      sha256 "cfc7b2ce5f1cef87f29618b721f7be08638a623470d16b5cc1475bbc4d39c74e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.29/arugula-0.70.29-aarch64-apple-darwin.tar.gz"
      sha256 "c297513e57950e4ec74d17d0b6da276350db41557bec18ca13a8c4f4e61d22e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.29/arugula-0.70.29-x86_64-unknown-linux-musl.tar.gz"
      sha256 "056ff1655828f52abc7058be30362ac8ce0568466301120fc17640b8e35ab25b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.29/arugula-0.70.29-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4624c43e427c8f86cb679813e9ffac248a45d5d620fa2e795dbac80ee07729b6"
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
