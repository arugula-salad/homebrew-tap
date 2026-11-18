# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.38"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.38/arugula-0.70.38-x86_64-apple-darwin.tar.gz"
      sha256 "0f2168da1353e93e4483457c8e867d817cda26abb531199959bdd17b5df6931e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.38/arugula-0.70.38-aarch64-apple-darwin.tar.gz"
      sha256 "7c5d7bd2287b793e0688d0c7dfe26ed07d2abe3e11455816b577828440d128e8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.38/arugula-0.70.38-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a9708a3b51c28f64d17d25fe22b8cbd1ea6a4a74f351a7e881c6bed30cb4647f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.38/arugula-0.70.38-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b6d6aa04c3032f223cddb0ed05b8b7a156483cf0b4a32ac8f9b5a7247e8e61a1"
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
