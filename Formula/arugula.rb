# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.102"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.102/arugula-0.70.102-x86_64-apple-darwin.tar.gz"
      sha256 "0da098ec7f39195444e4a9c7336f2a54fdf79dcd0f6dde091f641e52b19f2549"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.102/arugula-0.70.102-aarch64-apple-darwin.tar.gz"
      sha256 "378dc2e72423f47110a99e6ca7c1be58ca2f1bb4dd805f3f0f17ee308641bf64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.102/arugula-0.70.102-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e78039514fb02bf8044dd8afa6d1beea86001196106665b131b96987192fc5bd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.102/arugula-0.70.102-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f337e34c0fc651934d529bb6f660de64e3884174d5c4c2664414c7a2253ae7ab"
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
