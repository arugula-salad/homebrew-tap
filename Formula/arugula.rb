# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.68.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.0/arugula-0.68.0-x86_64-apple-darwin.tar.gz"
      sha256 "6911970ae77de953b1871c648faec21c5f35487e5855c9acf51986ae433f350d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.0/arugula-0.68.0-aarch64-apple-darwin.tar.gz"
      sha256 "fa74885e25e5d48d26134cbee7236213d6119fa9a765f3ca40ffc5ea14b84593"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.0/arugula-0.68.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "694dd7ad97f5aa38178645628f5b95fc0aa979864f389d040afcad820f4d637a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.0/arugula-0.68.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "60168b70522ea225bfb7bf91f9cea5ad0c08d92fcdb3aa15fdc47c026e27ea19"
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
