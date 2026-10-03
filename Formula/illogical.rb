# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.7.0/illogical-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "c8a529c770824e6a37c8e6e3faa7db5eefedfedc6ef6eeb46ce147b01b5a1eb7"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.7.0/illogical-0.7.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d38730890e5f140d08eb2783538ead5589d041687b45bf9e7ac8dc433e2f9212"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.7.0/illogical-0.7.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "050967b2fd0028a214711aadc4191c4794581a48771cc10be1440d3041b08f55"
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
