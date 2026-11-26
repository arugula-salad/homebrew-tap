# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.133"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.133/arugula-0.70.133-x86_64-apple-darwin.tar.gz"
      sha256 "834c3653d16e2ecd5cc6f23466107a76f2c7370423e198bc53b77e7b5dc2000b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.133/arugula-0.70.133-aarch64-apple-darwin.tar.gz"
      sha256 "965511e9326c30833d79afc84000fc02a5b7256d866b14a4fbcdb0dd6b42dee2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.133/arugula-0.70.133-x86_64-unknown-linux-musl.tar.gz"
      sha256 "19596b06e6203ca8ba750dada74bd4af1cfe8133cba87366eb1c31edcec739af"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.133/arugula-0.70.133-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dfefba4668617bbea29944452d18c03ad2190c5625f6696e153050907e015f0b"
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
