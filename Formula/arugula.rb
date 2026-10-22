# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.57.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.1/arugula-0.57.1-x86_64-apple-darwin.tar.gz"
      sha256 "829f4e107a6f2f324daff1c99ba373aed6051523d93354b390b5f6beec756cf2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.1/arugula-0.57.1-aarch64-apple-darwin.tar.gz"
      sha256 "bdc5fd705aa40c5069d99463a0aa32e654cd25d16a454b23de48485896889cf3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.1/arugula-0.57.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c3080b4e7196c35271e105d40eb1b94ef94e5e341955ecbe0d01d3e2fe0d9cab"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.57.1/arugula-0.57.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b922edd67c5c641ccb750053d9d8341e3a1cb2ead3cb4454dc0892e9c07763bc"
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
