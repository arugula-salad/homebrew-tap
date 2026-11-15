# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.14/arugula-0.70.14-x86_64-apple-darwin.tar.gz"
      sha256 "c87d8211e52cf5e6051ff2a743cf58c603e50e93c66de532f24a155a5631c157"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.14/arugula-0.70.14-aarch64-apple-darwin.tar.gz"
      sha256 "cb9a6dc79b6473227f397cf8580e0dc8e33646bab1ed1a6da2e5449f9725a602"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.14/arugula-0.70.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3c59be919c3ec56502c6310096f3bc5e3727de461aff2b0ea9750b5ae5ead3c7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.14/arugula-0.70.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5ae6f0737866a0aa5737f11d0567eb29ec145ce8c4879c9503aa813bdab5dbf2"
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
