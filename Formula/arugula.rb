# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.68"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.68/arugula-0.70.68-x86_64-apple-darwin.tar.gz"
      sha256 "fe62e9255d518413c27ca310c8543f63c4d75afdd063b5d9eea392533efdf444"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.68/arugula-0.70.68-aarch64-apple-darwin.tar.gz"
      sha256 "f621702b24ee03a3b0f43fbd83a475838ceaed95c58cc00742a535d9f8423548"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.68/arugula-0.70.68-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a0141c380bbd49a72007dde218764d70031586ebac10d87b9d947fefab61badd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.68/arugula-0.70.68-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8095a973a9e45863675aff4c5e2a633892943a3f1e35275c834bf96fc93940db"
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
