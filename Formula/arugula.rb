# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.60.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.10/arugula-0.60.10-x86_64-apple-darwin.tar.gz"
      sha256 "a53fceab3dc5ced54fe7c4ae08991474b886672db723368b1ef7ea24ea1cbb91"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.10/arugula-0.60.10-aarch64-apple-darwin.tar.gz"
      sha256 "1cfb3bbd0d61f8e5afc4ca88aac87d0cdb860f6ca33f8561612196041081da06"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.10/arugula-0.60.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5d877a88ddaf7e6761ae1574f51471ef815a3eadec9e1e5f7ea324ff6c8d3753"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.60.10/arugula-0.60.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9d26c91cddf9f08b9221dea6296012bb8214cb0407cb4fdb18e57e3145661547"
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
