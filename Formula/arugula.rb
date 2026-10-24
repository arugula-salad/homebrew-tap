# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.12/arugula-0.60.12-x86_64-apple-darwin.tar.gz"
      sha256 "83926caf4f7fe41687cba186544002a66ec347e376772431e270df29dc9ae306"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.12/arugula-0.60.12-aarch64-apple-darwin.tar.gz"
      sha256 "86d95965834c833d850dc46dc7f3937e2fc4c4114903c5768e1a2916d5cbab05"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.12/arugula-0.60.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5242000ffc1db51b8055e027c330ed282958ce74aac66aba4bd207bc1fb6358f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.12/arugula-0.60.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a23a380f68f2237002f52cb6663874b5bea183b9692c80dacd4602fdd9143e1c"
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
