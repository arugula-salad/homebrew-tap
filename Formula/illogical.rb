# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.4.0/illogical-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "d9b7170e004a84602d444c52a66730e3e1910bebdc271078c0453b8e0a2d5f49"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.4.0/illogical-0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e3a48ed3280cac5b33b75fc47139b6ead0eb8aff218de14509394c53f38fda83"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.4.0/illogical-0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6116a0aa69d04a57f183ab6c08017443cc81a9edb0344bb4d3266a0eca3e44aa"
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
