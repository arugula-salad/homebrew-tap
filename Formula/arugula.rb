# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.70"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.70/arugula-0.70.70-x86_64-apple-darwin.tar.gz"
      sha256 "dd0a1979080d6cc83f0cd41769e78dd91317d0e8dd73016b75e0c47d4a3ced4f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.70/arugula-0.70.70-aarch64-apple-darwin.tar.gz"
      sha256 "304e02bf5a541884c2c9230c87b4ebde1a58125215c3ce9056bc2862d473502a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.70/arugula-0.70.70-x86_64-unknown-linux-musl.tar.gz"
      sha256 "939c3489c66197739897f34908ecfbaf4572bc9ba09640b8fc4b40ea2aa4d29d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.70/arugula-0.70.70-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cb99914b3250da9bd4afb19acabf6e818d1eb59bf53a2960609473d4037ce725"
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
