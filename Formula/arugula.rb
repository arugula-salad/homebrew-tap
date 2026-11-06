# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.68.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.5/arugula-0.68.5-x86_64-apple-darwin.tar.gz"
      sha256 "e8ffb78b86c3efd974d2f57f8c0c84d3885425bbefbed0dd5dd72363ac533b33"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.5/arugula-0.68.5-aarch64-apple-darwin.tar.gz"
      sha256 "3f46395195478f3cf6a209b7aeefb1d1f55f947daca68930dd6e718b0c5b92a1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.5/arugula-0.68.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d96de260bcf53e6432de624a08786bc4739ae937cf9066bece997c5d95c9acc4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.5/arugula-0.68.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3fab46994d3a9ac1cd87aca32cad916e8bbbe294677848d9444b7ecd2f401738"
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
