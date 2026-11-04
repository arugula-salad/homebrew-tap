# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.66.16"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.16/arugula-0.66.16-x86_64-apple-darwin.tar.gz"
      sha256 "5cef5f61d5faed3f84cec62f09e8b55121b0165e2f8f243d41d7cc903c3519d8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.16/arugula-0.66.16-aarch64-apple-darwin.tar.gz"
      sha256 "136cde8a1f86fec7207e6d1a12882a54cc6082073733f09bd36c2464db29f2a7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.16/arugula-0.66.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "72e27f7b27771b8f1877f2620e34b77bdc4d01d87efc71801a55bfa42395831e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.66.16/arugula-0.66.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4d581c7ad498466c4eeeb3846d3fde863c9d03047287de1e63eb67f82d1792b6"
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
