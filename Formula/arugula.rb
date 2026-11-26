# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.118"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.118/arugula-0.70.118-x86_64-apple-darwin.tar.gz"
      sha256 "7bcce22004bd6b18262a2c4ffaeee8d0265729d03e301d2b6bfae8acf173c78b"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.118/arugula-0.70.118-aarch64-apple-darwin.tar.gz"
      sha256 "d25b316467798953c57ad432311a5674d4aab61e033cfb1d8ece53676cdb92fe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.118/arugula-0.70.118-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fda6a73930a9a6590debc88dda5ce5c5eccf980cb10acad1b98fcbbfe6af2b24"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.118/arugula-0.70.118-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2a21b56c0b8bdf19150e30cf9d61233e84fc826c70dd72e1e3950241b27e771f"
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
