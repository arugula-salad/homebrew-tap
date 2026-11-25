# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.106"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.106/arugula-0.70.106-x86_64-apple-darwin.tar.gz"
      sha256 "cbb7120d0ecbb66907982b2d038372a64b59fcbbb9eaddcf7cdd830dbefc8b47"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.106/arugula-0.70.106-aarch64-apple-darwin.tar.gz"
      sha256 "aaa583e7ea5c1878d236b84d53e1111e07cf4e83c26afea2e559f2a492992a82"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.106/arugula-0.70.106-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f61e8afc0b0120f4ae72e8328195b01fd08406f6911de3ed870fe75fdbf7bfa5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.106/arugula-0.70.106-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bbe40e5ce6fae6e58083bd012e312c9943ee2769b5b0423b1108c3c9865e7ac1"
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
