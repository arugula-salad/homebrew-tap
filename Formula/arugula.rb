# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.73"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.73/arugula-0.70.73-x86_64-apple-darwin.tar.gz"
      sha256 "d14ec076b549252da731003b3cfd08f948454ec8207ac185b72c4fcba0c00aa4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.73/arugula-0.70.73-aarch64-apple-darwin.tar.gz"
      sha256 "d8280f5ee09ea12239a22af7eb5f53ca4fc2cd0ca4875009f759d26a2dce5b11"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.73/arugula-0.70.73-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0d1737db7d24a73d9f3b38e8a0554992c59d83280b1d219f7441030cfa4468e6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.73/arugula-0.70.73-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dbbb2cf1fbc0b7a384d5f5f032227cbb38542b957c2bd1d2de4316ad3b4a9baa"
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
