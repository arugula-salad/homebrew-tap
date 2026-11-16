# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.23"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.23/arugula-0.70.23-x86_64-apple-darwin.tar.gz"
      sha256 "d829557f1b5c719f7e0e2878a479f086679f7fa6c7ebda0643cb5f22a1751cb1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.23/arugula-0.70.23-aarch64-apple-darwin.tar.gz"
      sha256 "56e2bdba077b46fe607dd383ef1cebbae2c40b3a38979aa7609fca1a7b21ae8a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.23/arugula-0.70.23-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eecbe83c82c129c066f4e27b49c6f5bd0d8ef961ee3518e345219ae936782ae2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.23/arugula-0.70.23-aarch64-unknown-linux-musl.tar.gz"
      sha256 "338fe56e999900cb8f4ea5411974c4405a21d56888118f02b44ff2baeb2b7e7d"
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
