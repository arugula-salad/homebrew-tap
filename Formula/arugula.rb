# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.67.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.67.0/arugula-0.67.0-x86_64-apple-darwin.tar.gz"
      sha256 "f4d6ad382978040affbddcd7648634cb84892b927860d673e04ea87ed27f5235"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.67.0/arugula-0.67.0-aarch64-apple-darwin.tar.gz"
      sha256 "546018b1d7787d96ce28416ddef891c69ba385bdf458d04fb87c8d4e50df05aa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.67.0/arugula-0.67.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ef2d687509615ff6b6853576efb568f3bf39511b0aa4c771bd553e0d4f4b8719"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.67.0/arugula-0.67.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2dcccc6e1dfe1bde6b3fd5716e68b2ee6fb7b7d8c1d6bc0c72a0b7780ce4b15e"
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
