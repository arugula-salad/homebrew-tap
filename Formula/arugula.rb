# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.8/arugula-0.70.8-x86_64-apple-darwin.tar.gz"
      sha256 "da582e87041ed6b8581a955021897c279310b564bed2e1316425ed39d8cfbc49"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.8/arugula-0.70.8-aarch64-apple-darwin.tar.gz"
      sha256 "af8b5187f9a5c539e0773430afdf47d95027cb18ff53ff52fabdc7d1dffad7dc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.8/arugula-0.70.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "43dd931bc2374072ff3420bf5baa9b5df3ba437a5f5253fd9a86eecfe730ef49"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.8/arugula-0.70.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f5b728b4e857033d7bb8840cbb5ee69ff8cc1e76476d2eb3cbfa32588ea0f862"
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
