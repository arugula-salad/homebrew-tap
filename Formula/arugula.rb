# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.146"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.146/arugula-0.70.146-x86_64-apple-darwin.tar.gz"
      sha256 "a8310150769de42aac28fd2de66270d3bcc3a8050a1a250c0381a1e61f0fe657"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.146/arugula-0.70.146-aarch64-apple-darwin.tar.gz"
      sha256 "f26941cd8e4bf179f02318cd8f807be0df9fcd3143271ce19af4ea189323c641"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.146/arugula-0.70.146-x86_64-unknown-linux-musl.tar.gz"
      sha256 "651e4a0eeacbcab3d0b1ccae7fa8c5b40172c16e741bf440133cbd249b8236ac"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.146/arugula-0.70.146-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c0497af5d232ac8167a40cd49f88007798767c92cf9041b15050aba9e703d83a"
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
