# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.115"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.115/arugula-0.70.115-x86_64-apple-darwin.tar.gz"
      sha256 "4a489df1b2fae24d167edbdd51623dc72bf81edd6989723258afcdbea44c474f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.115/arugula-0.70.115-aarch64-apple-darwin.tar.gz"
      sha256 "e69be9402b3c87862f9c59c76c336fde992a1ebc9cc3451f2508aafc5b8a947e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.115/arugula-0.70.115-x86_64-unknown-linux-musl.tar.gz"
      sha256 "83ae78fe037e639b7c7dd31a77cac660e79d0df183dab0a0dc8ebdab09336bcd"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.115/arugula-0.70.115-aarch64-unknown-linux-musl.tar.gz"
      sha256 "552d9e415ec98071da543d41b5fe478b8df6f4cd386a7a84ea55fc5b0b7475b4"
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
