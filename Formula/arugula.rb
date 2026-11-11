# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.17/arugula-0.69.17-x86_64-apple-darwin.tar.gz"
      sha256 "349a9b55f8e8e6704d4fccacc5354fc22d93ceced417fe83f0ed669d057c567d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.17/arugula-0.69.17-aarch64-apple-darwin.tar.gz"
      sha256 "75282a4b7e68931c829881ad9cc423698eb108392e233240bd35b2f3b148ec31"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.17/arugula-0.69.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d675512390ec3cd34e9e9445d0b47fae79b2adb40c46fa5592b2b480177651c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.17/arugula-0.69.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ac10587806df548d52da8b4c454bc44828b6faa04ffbe07c49de95be5bd1a386"
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
