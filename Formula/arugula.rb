# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.39"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.39/arugula-0.70.39-x86_64-apple-darwin.tar.gz"
      sha256 "ab5cdd0c0be504e39e372b600d901d40f1f544b666f85a477c6f016076280824"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.39/arugula-0.70.39-aarch64-apple-darwin.tar.gz"
      sha256 "665919ec0a94b31ddaeb8754a45304ba97cd72be6de66b79e9a8056efb353851"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.39/arugula-0.70.39-x86_64-unknown-linux-musl.tar.gz"
      sha256 "71146b0e61f68f0da449c77a0dd453f0542addaec7982965ec194a3c49d34007"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.39/arugula-0.70.39-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6b17fe132bdee33fe14892ac4e98df435b7fb5b891f4a406ce246937a0b33949"
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
