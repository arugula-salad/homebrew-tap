# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.9/arugula-0.70.9-x86_64-apple-darwin.tar.gz"
      sha256 "cbd8fe1e5b87a7e910343e32efc0179b68eaa0b14e696b5b37c66e1424038cbb"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.9/arugula-0.70.9-aarch64-apple-darwin.tar.gz"
      sha256 "d05e3b603daaca48f4c9792dac94dcfa622bc9c494a1b8e7b9fee2c7d570de7e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.9/arugula-0.70.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c3032cf582a532020d47e8023190478589b9c83f2aadfb99d3566bcf628a412b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.9/arugula-0.70.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f7d20149c47cbad169a38d23c7f003173fa043fb1b98d46f80b110fdc0a1f850"
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
