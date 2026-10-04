# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.15.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.15.0/illogical-0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "20a669782efeed5a8afa4f60962a77ef1e576fa3fc427db485c9c5ead1703d80"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.15.0/illogical-0.15.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "12e2b4f62fd9183bd5b0b827de3ab154beefff5e0f77860a9c29de5708f3ea6e"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.15.0/illogical-0.15.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9506c230f3c65b99b811f9ed3fbb59e337a20035ab47769a15e5740c50939770"
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
