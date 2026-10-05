# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.17.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.17.0/illogical-0.17.0-aarch64-apple-darwin.tar.gz"
      sha256 "83e92c374624ef7020bfdb2905d1f18b843ad208db934f65b7ab940251dfdc3d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.17.0/illogical-0.17.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ea2e7de24e28783c954d1736b4ad57bae297b3a7f9a2e6eb64e3f07b3fa7f73b"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.17.0/illogical-0.17.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ed1396fc7046e5895c55b3191fe445340741cef099131d3c2efb7ebd5e17ed25"
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
