# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.22"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.22/arugula-0.70.22-x86_64-apple-darwin.tar.gz"
      sha256 "fb8e093031ccaa7e4e453ec94bb4f1472ea852b5f4ed6b2f967f7ff9b9f9ecd0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.22/arugula-0.70.22-aarch64-apple-darwin.tar.gz"
      sha256 "9c28d7b0a21c17028dc5d5c8fdb8760aa7e3e95d87f5a4ebf1ed3b0ff2d749be"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.22/arugula-0.70.22-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f8d03a4e85a5b7d9c929ab8a33c383abadf6d7b49328eaf2d3db9ae41fd9272c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.22/arugula-0.70.22-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e11435e2d5f02d3c5aa7f1aa92ead73da94fa69771876ba53819cfe519da44e9"
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
