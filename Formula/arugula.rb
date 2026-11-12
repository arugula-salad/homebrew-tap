# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.22"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.22/arugula-0.69.22-x86_64-apple-darwin.tar.gz"
      sha256 "a8cfc76f85701b6531dfc80fe4034f8da7db1a46ccaa275b43745428e3e620c4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.22/arugula-0.69.22-aarch64-apple-darwin.tar.gz"
      sha256 "ef1200de24d68bebc4f100f5099d1d9389ebacd5acd434d986d0786231cf6a67"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.22/arugula-0.69.22-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e5b2ae3895a10e11b2d1d73dc4e19089a6e4cfec2b6d367fe03f9908f6c4c31b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.22/arugula-0.69.22-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8a564f7b28818ffead84850adbd830b6c93a4d7ee2d75b379c597ae594cd1789"
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
