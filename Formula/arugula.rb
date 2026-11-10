# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.12/arugula-0.69.12-x86_64-apple-darwin.tar.gz"
      sha256 "617544202088fa7f1522ff80f366b0b001fa9e600dab2ad837f8074f21c59ec3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.12/arugula-0.69.12-aarch64-apple-darwin.tar.gz"
      sha256 "de00d78b04937f9f0ebbcb6da8dbe16c44a520f8e579bf5f03901f2201f024f1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.12/arugula-0.69.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9d9dee1899b09e492e937715c94a3d870f4ffa512a8af70a19f5ec35e6fcb87c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.12/arugula-0.69.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "59057916310a1cb0f7d304b80efc6c26b070d9b654c8cbcdc8aa9569af4bc96f"
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
