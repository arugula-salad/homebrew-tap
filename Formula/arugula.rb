# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.157"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.157/arugula-0.70.157-x86_64-apple-darwin.tar.gz"
      sha256 "970ab588b00f8493697a39b3dffa092c4fca17e82056422a63625ee17b5c31a3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.157/arugula-0.70.157-aarch64-apple-darwin.tar.gz"
      sha256 "5e5772c543a6a2007630fb5e07a2065ae12a2f25a88790b5d32414f76fc1b830"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.157/arugula-0.70.157-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ed70f39d0a0422035740836653ccfa5686329125641e211aaf4e37ed16bfc136"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.157/arugula-0.70.157-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9057284086b061a115c09976752c486d4313948a3781c90124fae8b5bc249fab"
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
