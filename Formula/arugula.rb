# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.23"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.23/arugula-0.69.23-x86_64-apple-darwin.tar.gz"
      sha256 "91cef2ea5c2fecd4e7adce219e79be8b295ed6d30286e411e39bef8a246358c9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.23/arugula-0.69.23-aarch64-apple-darwin.tar.gz"
      sha256 "abf24c5fb39431e33d47c24c807914455df32a0693c055a6847b04e885d83e01"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.23/arugula-0.69.23-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d1ab3609bf21f41df3e80b99f40f25b8d7af20db62d35e1f8216d8d754e4b227"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.23/arugula-0.69.23-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c4854772a4f8df7ef987be070f310e65f237242a6e41259997a6643a0c2d8714"
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
