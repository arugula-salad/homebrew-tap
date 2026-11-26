# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.119"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.119/arugula-0.70.119-x86_64-apple-darwin.tar.gz"
      sha256 "04aa45669e99be36b675625076f2db8ab4092f16b4bcf1257c466858e49934f1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.119/arugula-0.70.119-aarch64-apple-darwin.tar.gz"
      sha256 "82cbbfad01f5a99a026d0f70b9bd08534e9f53a85bffb129eb1e3fbaf9064528"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.119/arugula-0.70.119-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9984b5d7d13c61c42ed8086b9c9fe1d87ae6307ef4ecde37c7886577663479a2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.119/arugula-0.70.119-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b5e64b24d23a2bb4c3091e31a6d597193fce60ce67296ebf85828bafc15d7cc3"
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
