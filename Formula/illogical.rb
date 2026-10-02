# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.6.0/illogical-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "43ee16322839bc1119595bafdfc80c396b57ac6db851e637a4d571578172bb4d"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.6.0/illogical-0.6.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3c856e81940706b14159c603cdce85a529532ee3f34156908179a127afb7d05d"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.6.0/illogical-0.6.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3a3c4f3167738c9d2476b486c47154d7e3a5c0ea1808ffcbb126b4f5d30c7c08"
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
