# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.25.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.25.0/illogical-0.25.0-x86_64-apple-darwin.tar.gz"
      sha256 "f0734ccfd6070a64c72e9bd8191b64e37229747112ae8f9dc58b896375e01481"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.25.0/illogical-0.25.0-aarch64-apple-darwin.tar.gz"
      sha256 "4616c50639060d2d036130e2cedbb81deac087dae99d193a3232bd38c5f6c598"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.25.0/illogical-0.25.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c7665b0740f132bc03036fc1eccf58bf3c2af76edcaf75773c1d6afb6ee74a7a"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.25.0/illogical-0.25.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9733073d5fc29db2303a5ad561e9adfa575e3abc6482709657ae021b32150225"
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
