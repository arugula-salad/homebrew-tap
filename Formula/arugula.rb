# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.5/arugula-0.70.5-x86_64-apple-darwin.tar.gz"
      sha256 "f0f7677c97e5ec5a16eea52f2cd07a6ce43140f8f7635adf84ac187116dc4e52"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.5/arugula-0.70.5-aarch64-apple-darwin.tar.gz"
      sha256 "f700a0d76d4b5544b6df96a2c6c8964be6a27a4d33045e1293ca3c83080c9fa1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.5/arugula-0.70.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "02dd47d075147280c070a88fff7b60015fe106e76abaa78c8c4d38d285732e9a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.5/arugula-0.70.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d3db0759b311fc4b0057abd0320d52b6212beddda09ffd9cf1ad049b3cacc60b"
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
