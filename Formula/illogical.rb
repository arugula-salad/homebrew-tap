# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.14.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.14.0/illogical-0.14.0-aarch64-apple-darwin.tar.gz"
      sha256 "a915cb18c5bb8d46530af7eeb247eec7e15b6e1339bb180ac11124d0a510bcbf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.14.0/illogical-0.14.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0d6d633e1dfabe2d525b3ef259c2e44cb69af921bf3df5fb0b1996e11cdd294b"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.14.0/illogical-0.14.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3e4e020ac901003540c7389b4ca24252f51eb89da975ad4440f97dc528aad332"
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
