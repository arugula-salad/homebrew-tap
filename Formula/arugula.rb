# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.71"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.71/arugula-0.70.71-x86_64-apple-darwin.tar.gz"
      sha256 "e096d8bcbbe52373fa9045c4921293dc5a5af1dc2c24010c6bf03aff22cda50c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.71/arugula-0.70.71-aarch64-apple-darwin.tar.gz"
      sha256 "0b21ce0a04c7f5a5b1929ce6dc689f6e0e4c64c4abb01193d73f005c6aa70fda"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.71/arugula-0.70.71-x86_64-unknown-linux-musl.tar.gz"
      sha256 "704b897c7b5c9c2ca86d5a09ec0648af6355bc55085dae5f9d4edf2cf387eb28"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.71/arugula-0.70.71-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4ec8cff449d1cb08ede050c4f38f696c8b11aed97f61a2731b33211cbcbae466"
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
