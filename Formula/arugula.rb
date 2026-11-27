# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.149"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.149/arugula-0.70.149-x86_64-apple-darwin.tar.gz"
      sha256 "82c285ffbc84d52dab736f45fd46e4f59bde7a26f486b13cbade0c3ed8dde569"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.149/arugula-0.70.149-aarch64-apple-darwin.tar.gz"
      sha256 "32281f5b1e4231360e4bcebc5660e42e5e122315c0f0b14c1d0cc6bebf2314fb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.149/arugula-0.70.149-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ecc0a6ba522634bcb3affd68510fe3fc7e1438b17bd1aa9c5564a25eba8d66ed"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.149/arugula-0.70.149-aarch64-unknown-linux-musl.tar.gz"
      sha256 "95b5ebaa4435adfdced7dc860bd7a6111584b7cb57d14c1f347ed097ba92e2bc"
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
