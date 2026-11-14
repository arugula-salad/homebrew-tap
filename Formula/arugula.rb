# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.6/arugula-0.70.6-x86_64-apple-darwin.tar.gz"
      sha256 "81a3437f07f3c05769a773d90ca968522ae753014461ec21e9e7a7bc0d215328"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.6/arugula-0.70.6-aarch64-apple-darwin.tar.gz"
      sha256 "65fe5f70f44924d8e997a3df78b2bb3be9b9e9b564f9562721232bdc5fc3951e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.6/arugula-0.70.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2423d4bb34e5d950900d42dd5ed5ddb7fb3bdfdd70f039b4be68ae57c7dfe3ff"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.6/arugula-0.70.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "df541b608b0e811cca8f7f45725a4c1f402420eae35776651c6abc5c475f0821"
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
