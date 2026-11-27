# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.145"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.145/arugula-0.70.145-x86_64-apple-darwin.tar.gz"
      sha256 "39672a2bd442021337286702a6f90206a57b73bc9c9e77574f24c2289e13e525"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.145/arugula-0.70.145-aarch64-apple-darwin.tar.gz"
      sha256 "774833b70b12d54aeec62542a3b2e553301276a2f1615d4902eb428dddece185"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.145/arugula-0.70.145-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0f826fbff8dcd253d6d0ab9de3cb21f388a6b5611f9632eac18909c9aba74e5d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.145/arugula-0.70.145-aarch64-unknown-linux-musl.tar.gz"
      sha256 "72c94fd06403a11e59542a536ac070250a02298b2926c0cd1541de90e834cd0f"
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
