# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.12.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.12.1/illogical-0.12.1-aarch64-apple-darwin.tar.gz"
      sha256 "4eec1b42a114c2c1ab0547eef79651bea6fc0b94041a4f3af5bd5fa05b281fac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.12.1/illogical-0.12.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b07d10f5179197970a62d6741e0991da865a7dc3e1ef13f01b277a9e7d40dfe7"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.12.1/illogical-0.12.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5d1d0e4775f76fdfdadeb475d2f2d58050dcd0cac7c5c8880c5accd004beed41"
    end
  end

  def install
    bin.install "illogicald", "illogical"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        illogicald install
      It copies itself to ~/.local/bin, runs from there, and prints the
      next steps: where to open it, its logs, your phone (Tailscale) and
      illogical control. Then, for Claude Code:
        claude mcp add illogical -- illogical mcp
      Docs: https://illogical.widgets.wtf/#install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/illogicald --version")
  end
end
