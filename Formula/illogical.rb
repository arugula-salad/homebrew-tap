# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.10.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.10.0/illogical-0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "c69e419069f8d27e7d65bb8466805630bb00467144cacd007ceb992818929424"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.10.0/illogical-0.10.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "60cff3a6f658745716403343aa625214389fb8f89d4a3e5d9f8883a1de509d8e"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.10.0/illogical-0.10.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6be354f50d4ebbe7c2cdfae373da08f71ea99da7081d8a051ff24a65f9d34301"
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
