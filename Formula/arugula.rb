# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.19"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.19/arugula-0.70.19-x86_64-apple-darwin.tar.gz"
      sha256 "7d4f35319f7114f0a3c4d75f5118a9b20bfefde02ca7a99032e5a6db60beba68"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.19/arugula-0.70.19-aarch64-apple-darwin.tar.gz"
      sha256 "5bd35d9c565bc395c0b9459946fba57d87967636ec067e65fe7472576da7ab39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.19/arugula-0.70.19-x86_64-unknown-linux-musl.tar.gz"
      sha256 "08dc6ca9a472c75bef4444331ea9af2987dd61a0462ea93d81427d0a0baebf43"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.19/arugula-0.70.19-aarch64-unknown-linux-musl.tar.gz"
      sha256 "82d938dabcde3b68dc8f31578e68011f6756e8302927871e6019be2fc10befdd"
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
