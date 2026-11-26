# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.120"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.120/arugula-0.70.120-x86_64-apple-darwin.tar.gz"
      sha256 "be6f249dbd3c97fedf16a2a2b86d0b655ac6d3dccb3c3828b7bb4f69e0647af4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.120/arugula-0.70.120-aarch64-apple-darwin.tar.gz"
      sha256 "be5e635e8fe127e395b6424041cd3648f18c9b793abc236e31895951f879a9aa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.120/arugula-0.70.120-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1c57b49df4b0723384071d636fb02b715f73314f9218d9f291f7b92e4aa1357d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.120/arugula-0.70.120-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eb629a4306e96ae38d18fef54c448c26a5303b50dbe287522f00741e4a703741"
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
