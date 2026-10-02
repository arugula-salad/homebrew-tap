# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.1.0/illogical-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "193e88c1fd66ca1d031c8c2c21b4f9b07c18a8729817341a6a7d936564a5a915"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.1.0/illogical-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ea6cdedeec2c96fdf53c282962c176af84082017cd873086e5a46ef966fb4358"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.1.0/illogical-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "04ee656f36c87058e4fd9605a921d8440d828ba4aeb88bcdceb71b779ea66405"
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
      It copies itself to ~/.local/bin and runs from there. Then open
        http://127.0.0.1:7681
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/illogicald --version")
  end
end
