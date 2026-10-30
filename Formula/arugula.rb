# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.65.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.4/arugula-0.65.4-x86_64-apple-darwin.tar.gz"
      sha256 "f011f042085e4c7a22ad24b1ea3dcf6e910776f1a92ada34787537e0eb9daf25"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.4/arugula-0.65.4-aarch64-apple-darwin.tar.gz"
      sha256 "55ba49ea199a0d6e5ba19ae996fdd2d815fd28478db348015e061cc2e321de73"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.4/arugula-0.65.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3f20e95410bf6cb6c55c13e92603cbfcf8fa32049751fd459361e5a726b4bf29"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.65.4/arugula-0.65.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d000ae44f68941bcfa320bbe68a206be8ce6781a0a4108c964f4d5c75e2520fe"
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
