# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.88"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.88/arugula-0.70.88-x86_64-apple-darwin.tar.gz"
      sha256 "a4d912f6aede8d019df7fd3375b7265deb19e98c6879785687a83fa629b22b3e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.88/arugula-0.70.88-aarch64-apple-darwin.tar.gz"
      sha256 "268ec2c38ed9e4d5020668f35dafbd8bf0a5e5c375914ebe5f594250b1d11830"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.88/arugula-0.70.88-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1f497bf0d14a54d6539b5a0ea2b1ed7f416a5923c0d557b5a649d6cff677d654"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.88/arugula-0.70.88-aarch64-unknown-linux-musl.tar.gz"
      sha256 "11e238837f58f67a1b9cd75b952be4c1b8079b2f26d3000dd1bab8f11e0d8079"
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
