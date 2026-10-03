# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.9.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.9.0/illogical-0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "00fa01bc1f4bcc3e52b92838cd3f57ffc1e9d5f88343a5a81fc5eadae4f0111e"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.9.0/illogical-0.9.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8c1ef2b089ace084e34a8f52b239afd5f91f95e999154e4e0be480e7f669d982"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.9.0/illogical-0.9.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fcec4b23002624746fa6d297c906c69c4335daf259e6f260f99507fa5cc904ab"
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
