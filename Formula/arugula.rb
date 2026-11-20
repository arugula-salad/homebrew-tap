# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.57"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.57/arugula-0.70.57-x86_64-apple-darwin.tar.gz"
      sha256 "2accc04599ac29014bbe3111294a629d75975e63f7036878f7eaf815a6866846"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.57/arugula-0.70.57-aarch64-apple-darwin.tar.gz"
      sha256 "a664c6b21e413ca926c7d095a5bc5ca3a249e0d291ad48da1ea6e4d94d6ba931"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.57/arugula-0.70.57-x86_64-unknown-linux-musl.tar.gz"
      sha256 "497e2443f17c1fc9e1aee2fd3af422bbda83de33a2ff90076f25b72551c69307"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.57/arugula-0.70.57-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3b1190835113f092b316ae1058547b06d228bb1e863357b1f60d7fea06fb460e"
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
