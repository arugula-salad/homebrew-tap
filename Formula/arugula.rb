# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.46.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.0/arugula-0.46.0-x86_64-apple-darwin.tar.gz"
      sha256 "7aa9b7fd4bba69f65a595efef19ecddee3095868d9f2ae2ef50ed10fca3fb8f7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.0/arugula-0.46.0-aarch64-apple-darwin.tar.gz"
      sha256 "b8d25580ec560f48cff85a73da8e8d5eae59bb6e79a65479fa02c5d9cbf73823"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.0/arugula-0.46.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7aff5db7baec4af1f7c431107df34ad9b000784b0c1dd9ab3326d19ce8d1cf62"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.46.0/arugula-0.46.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b355e04066bff812427408a6ecd9fbfe8aefab219fb0ab49783818871b063790"
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
