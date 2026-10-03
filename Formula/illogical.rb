# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.8.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.8.0/illogical-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "1923342e26c84282ced739ab6b4276f831fac905d95381992ea2d2fd4b7ea639"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.8.0/illogical-0.8.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e76f39642ef468b11da54344334d064b07998d09c6c6360f5794f4d04d8a3fbf"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.8.0/illogical-0.8.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b9762b114511b5e4d8055a4fdec660d314acc00b56379d0fb51d15a9ec241c41"
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
