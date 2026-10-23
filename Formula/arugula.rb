# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.5/arugula-0.60.5-x86_64-apple-darwin.tar.gz"
      sha256 "8dbc3550caf8a8f45799042820a409b6bba28ebbcc71980e25087ac043b17ae3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.5/arugula-0.60.5-aarch64-apple-darwin.tar.gz"
      sha256 "2420bb3b49d24403b988cad41f69c067f6491d6a2caca172c1b507aca75fd270"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.5/arugula-0.60.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "85d717833ce263cb3d32dc8deb63d7098e3063989f5b17a53ae287737404b1ff"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.5/arugula-0.60.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5a496f3665c1d78435a78c86f307d8788ff4cdc17e8b33bb58c68f9626ca9981"
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
