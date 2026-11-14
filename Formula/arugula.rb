# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.12/arugula-0.70.12-x86_64-apple-darwin.tar.gz"
      sha256 "dbe865f15df6f223a4998470b8ec655ddfb1e2e32952df02fa1ea1a4035a1926"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.12/arugula-0.70.12-aarch64-apple-darwin.tar.gz"
      sha256 "556cd455d4ce35e3732f65c31af717bd942df6d72479682b875433fb48fe714a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.12/arugula-0.70.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e064de5b22e3a07f30f0e737e57a0122d2b796a9071b03080df3c2aa0aad1276"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.12/arugula-0.70.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "44d3452eecfac277e51e255bf0a86ef22769d0552d5e47c19e494987750c84b1"
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
