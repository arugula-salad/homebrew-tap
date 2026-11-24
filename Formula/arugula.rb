# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.97"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.97/arugula-0.70.97-x86_64-apple-darwin.tar.gz"
      sha256 "797538ece62c289443b2309b069da1dc546ab4fb3028980247c4d9b486b673d2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.97/arugula-0.70.97-aarch64-apple-darwin.tar.gz"
      sha256 "bb5fe9f54591c9476ecfe5b243a6b886ccdaaf4ead8fc5f0e40e654a7fd66d96"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.97/arugula-0.70.97-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9ee927f68aa07dc0d60d8ab04dd5c4bfe58efeb258dc9aacca423a8231f0409f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.97/arugula-0.70.97-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b76e0db39435401543083f1f89f8bfddbe1e69f69061bf22890da8ac0510eb80"
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
