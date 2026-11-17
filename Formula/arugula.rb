# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.35"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.35/arugula-0.70.35-x86_64-apple-darwin.tar.gz"
      sha256 "face4a99158c0712769d235aa2f91cc2727a9897e30664567e51fa245598aedf"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.35/arugula-0.70.35-aarch64-apple-darwin.tar.gz"
      sha256 "d331bcc6729deeb0f9f7c6e5dcaa20626b75290a36d5a4ae0c83dfaef00f15c6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.35/arugula-0.70.35-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1c8be6ab0a6e0d1032a92f8556ff3f9efc97f7c7e75bdb0e10099db8915b7c84"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.35/arugula-0.70.35-aarch64-unknown-linux-musl.tar.gz"
      sha256 "50b46609427b1814b98ffc1348e55509fddb3feff5e17eda6da4fa3693622a7f"
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
