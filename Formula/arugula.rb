# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.85"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.85/arugula-0.70.85-x86_64-apple-darwin.tar.gz"
      sha256 "874ef1b12cc80980f803feaa0deb05088aef6f5cbbaa43c9d464eb4ede55e74d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.85/arugula-0.70.85-aarch64-apple-darwin.tar.gz"
      sha256 "c3dbc5a10e2d3f3bdb0280a5eab9684cfc41319eb3193f1478f09a72c5b27e9f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.85/arugula-0.70.85-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c5e5c60691fe4d1222777d5a44954c12325c5344ec03a469baa23b98e9b5bcd7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.85/arugula-0.70.85-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3d556934b560b9135999a818ff93a1e121e68c1d612147ab0a7687e776472ff9"
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
