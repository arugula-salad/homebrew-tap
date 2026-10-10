# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.32.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.32.0/arugula-0.32.0-x86_64-apple-darwin.tar.gz"
      sha256 "d215ad810a9ca5a0e7d096caa3b29c25f740a7d9d5588ae652b3ca139dfd5639"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.32.0/arugula-0.32.0-aarch64-apple-darwin.tar.gz"
      sha256 "e29763831b21bc72d2d3c43e9b752342ad798d69339d81dc96cc72270c2fee9c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.32.0/arugula-0.32.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1596b0c69dadaeeb0d4cc3f4a6da0f7c2be59abdfcb3af84311d00d6c3a059d2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.32.0/arugula-0.32.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9b071f0ea1a3d7e2d8d9b3c0aa66c34ebabfe5d9b66a7890c7a6f34f248dd461"
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
