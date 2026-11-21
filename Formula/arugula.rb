# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.75"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.75/arugula-0.70.75-x86_64-apple-darwin.tar.gz"
      sha256 "e7080bd3d2c98799be68a4ff34a30939adf09ebada0bcd1697019474b68465e5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.75/arugula-0.70.75-aarch64-apple-darwin.tar.gz"
      sha256 "19c00ab736335a3f5aaaf784924a5050c0fe8b4028c344a4d2a897e741646b4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.75/arugula-0.70.75-x86_64-unknown-linux-musl.tar.gz"
      sha256 "865a0b93ee79596cb6c6a8f4bf3cd7d5fd6d572691dc4b2ed951e64e561b1348"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.75/arugula-0.70.75-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f3b25e2ebef253a19d8f28c42110e2e1095e22e7c6eb289e2160193930dc3d2b"
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
