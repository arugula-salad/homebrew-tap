# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.126"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.126/arugula-0.70.126-x86_64-apple-darwin.tar.gz"
      sha256 "d0b41da767c20fb805f786e1f3454bebdaeed5f984e945f07d5945c687d059d5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.126/arugula-0.70.126-aarch64-apple-darwin.tar.gz"
      sha256 "17d8633cd90a0756108cdfccc8945f7c6221bef67d97e27e004d8297dd8e6dd9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.126/arugula-0.70.126-x86_64-unknown-linux-musl.tar.gz"
      sha256 "225a7e761bc5b9d8c7a7172f547a4ab87af270e8d36be8b5e99b9f3ab2d68ad9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.126/arugula-0.70.126-aarch64-unknown-linux-musl.tar.gz"
      sha256 "053239dfd773015433afff4cd73fd887fab30dfe04dcaf372fca238868992562"
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
