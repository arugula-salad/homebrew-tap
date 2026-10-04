# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.12.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.12.0/illogical-0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "f83bc506aa290539e041280fa8911dac97550fa629b588b3527ca82ee1dd4898"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.12.0/illogical-0.12.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d821712119f9d29026172384da634580537b50aefc99e7608973acda8840f41"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.12.0/illogical-0.12.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7697a2afbaada580f15681a6d4c2ef2639ba78ec3a957c3505989c4950a7e33e"
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
