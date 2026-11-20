# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.58"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.58/arugula-0.70.58-x86_64-apple-darwin.tar.gz"
      sha256 "91ba07c54aaaa2bcb6ba5b74bb2e5ad9533551743243e9d1c83e23f3157f6b57"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.58/arugula-0.70.58-aarch64-apple-darwin.tar.gz"
      sha256 "28accf12994ed36d6309a41e2eff7a187887ed772125cbc7c3d3eaa7199bce3a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.58/arugula-0.70.58-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6650007cfe45be7a71360bb4c0ab2a736ab7ec6af591809038598a2509396e44"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.58/arugula-0.70.58-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d44237dc13274e09ed6d74c81b316f3ae6201adfd6acbdc8be61ce85d891e878"
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
