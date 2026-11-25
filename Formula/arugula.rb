# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.116"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.116/arugula-0.70.116-x86_64-apple-darwin.tar.gz"
      sha256 "82e3ba407bed1dd26f6dcd271a7ac0f15f2317b3908965a9eac19e286b4f233b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.116/arugula-0.70.116-aarch64-apple-darwin.tar.gz"
      sha256 "d4773bfda0411c2c8dd39bdd2d99b58b3cfcf0117996799f07521410d26f2260"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.116/arugula-0.70.116-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ee946bfe40cf9fd77a7ebed20046f282dc79ef1c249b91b24f79213d3a8c8203"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.116/arugula-0.70.116-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e16bd753a27f7804f453706f257f648891bb36c9e45f5e915c9cf27680dd8608"
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
