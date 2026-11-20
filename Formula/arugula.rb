# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.54"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.54/arugula-0.70.54-x86_64-apple-darwin.tar.gz"
      sha256 "1c50efde604e4493d480bf28453e1f210601d0f954ae51ed07a0210d3b5a0796"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.54/arugula-0.70.54-aarch64-apple-darwin.tar.gz"
      sha256 "90225cb458494ace72f724c16021cde2b405fca83c0548e6345a481e4ec69bb7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.54/arugula-0.70.54-x86_64-unknown-linux-musl.tar.gz"
      sha256 "af7091abf4a291d2516fd3db08f26db66003f6534e2d40fc66fbf72a3bb4a1a2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.54/arugula-0.70.54-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e466d07db5b6fa67b9868d2685e5560727d0f4816272d313bbdf6d452286e5e4"
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
