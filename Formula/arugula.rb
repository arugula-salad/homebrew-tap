# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.11/arugula-0.60.11-x86_64-apple-darwin.tar.gz"
      sha256 "57e2d2d1a5bc75978f72ac8419d74e36422221e45af3ccdba12acc3b76d423ad"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.11/arugula-0.60.11-aarch64-apple-darwin.tar.gz"
      sha256 "5d5f752d804e896974403d1b5bca1aac860f86a7837ca8677c0ce6dc375f4101"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.11/arugula-0.60.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d5e837e173319204f49fa538b9a17f94354d69c033521c1d568a2bf3630e4344"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.11/arugula-0.60.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9325eeb662a5611f6a4ef1ee9cee4f1e0464ab677b3c9b93356a8130530bbd94"
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
