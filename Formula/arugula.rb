# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.127"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.127/arugula-0.70.127-x86_64-apple-darwin.tar.gz"
      sha256 "0f457a9713e389227d82374c5422a67a6255082051307e40b8575989dcf568b9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.127/arugula-0.70.127-aarch64-apple-darwin.tar.gz"
      sha256 "1abc32f7ca7c4c69584ae1a1386f74cc85bfc0f4b1ef44fce45f9d8e476e2017"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.127/arugula-0.70.127-x86_64-unknown-linux-musl.tar.gz"
      sha256 "40aaa6fca2a8e54f7ee14d7f6ab40deffb1f04590d0ccf8e8c1680e3184aeed8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.127/arugula-0.70.127-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ab7e6b88a46093f0c99fe99492f4c467ab66ea88bd4034bcc78dd0f71dafdade"
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
