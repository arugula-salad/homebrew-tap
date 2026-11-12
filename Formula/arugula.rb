# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.20"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.20/arugula-0.69.20-x86_64-apple-darwin.tar.gz"
      sha256 "1c1178344881f068c564c78f9ffa1417de3116a358b23a24bd47328cb4122bb4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.20/arugula-0.69.20-aarch64-apple-darwin.tar.gz"
      sha256 "098c09f77390be2c922359a42c7f5eedd19ae051d59537203133bc214c01d21e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.20/arugula-0.69.20-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6b179c73bac766890986b207025d54c666804ae4c5dda33e4b7badc8390fdbb9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.20/arugula-0.69.20-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e7014cd6f8ff5abb45f53254422e2063ddbdaca5f991b014711206399dfc73a9"
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
