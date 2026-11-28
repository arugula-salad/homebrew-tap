# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.161"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.161/arugula-0.70.161-x86_64-apple-darwin.tar.gz"
      sha256 "1e5c48408cd6d160d116c67f2e23fa49d8e2ea0913cf26b1f55f80cbc9089dda"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.161/arugula-0.70.161-aarch64-apple-darwin.tar.gz"
      sha256 "7ab7951c8241c7a02abd6ddb56daefee034d166f0ef3b5d6b76c08b426261ceb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.161/arugula-0.70.161-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c739c84a403c38068a95a0d2eb0ccd947dc3bd35f37991beca64eb71b2b76e29"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.161/arugula-0.70.161-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ba26541b376219832c23cf9cf93f8302f26c2f50c12a05bf7267d3098c35dd18"
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
