# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.32"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.32/arugula-0.70.32-x86_64-apple-darwin.tar.gz"
      sha256 "283b136bc41e4da0cc3495850590712c39d2c66548e97834d3a52d3f75b2dac7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.32/arugula-0.70.32-aarch64-apple-darwin.tar.gz"
      sha256 "292caeb143f6bc04a6f12f604d170542b08ae703518685474861a9f0c1c213d1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.32/arugula-0.70.32-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3f8c50aeecdf2abef6362bd0e2c9ca77252a4b577fcd7dc3af8dbe0220e99c01"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.32/arugula-0.70.32-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b328680b98b0c2cefbc7334a94a7b17f1eccd7fe078c502764dcecbef35c8495"
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
