# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.79"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.79/arugula-0.70.79-x86_64-apple-darwin.tar.gz"
      sha256 "9a65f2dee4fa8a0cf7395af5e415acadd7c4a67a93acc1a934f94a5d6d21b204"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.79/arugula-0.70.79-aarch64-apple-darwin.tar.gz"
      sha256 "b40a93ec5618343a08a075805a4afbf5922c26adde51acc10cc85b8a1796dd19"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.79/arugula-0.70.79-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c3b4674a4f3461fb9ce1efdbd6851e0844978d756a5ecf2f406c1fdd160cce26"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.79/arugula-0.70.79-aarch64-unknown-linux-musl.tar.gz"
      sha256 "77c13140a02300cb82cac8aa2c5e36d930af4aa5777450986e1ebd0a753f5169"
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
