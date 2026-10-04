# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.16.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.16.0/illogical-0.16.0-aarch64-apple-darwin.tar.gz"
      sha256 "34a59a4c9dd0903747ef3eab4a2d6030c1e51927474b5444726c455690d8189a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.16.0/illogical-0.16.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dbe74462cf21dd4f3a3ef160728c3f18428f00217a978feab5fd258c2dd9a0c4"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.16.0/illogical-0.16.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5438936004fcf79fb516592da0872e045a73a87d480f7b15d2e5e0a4ff974d31"
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
