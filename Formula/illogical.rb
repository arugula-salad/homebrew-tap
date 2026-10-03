# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.9.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.9.1/illogical-0.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "14dfbe4dad1c57281ac7869eba28285c26385afa1474cc7f6c806457aebc908e"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.9.1/illogical-0.9.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "aef5ce29d8072063b6cfc6db357ae016c373274c6b726f717995f957144f65e7"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.9.1/illogical-0.9.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7dffe7446530bfc54697164bde73fe4dda68e414ca87832f715e1f950817b2a4"
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
