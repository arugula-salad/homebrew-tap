# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.22.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.22.0/illogical-0.22.0-x86_64-apple-darwin.tar.gz"
      sha256 "c452589e87e23521f0836e426abc18eb966cd1f2875767e56d8614bdcbbdd517"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.22.0/illogical-0.22.0-aarch64-apple-darwin.tar.gz"
      sha256 "11805b47da5b70ba50e30760bf96ffe17eb971f9e7a08b50281011a58c2b869b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.22.0/illogical-0.22.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "037861660e9e41dfbcd319c2b1ae9e03113259ed9b180caf3447ded1def403e1"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.22.0/illogical-0.22.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "56f527d1fafc242a4aee626ffae6a754c6bf67218031c208c14f5d5b009cbc57"
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
