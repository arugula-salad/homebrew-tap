# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.2.0/illogical-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "e7e094c07e46a63b4953ebcbff341bdf20df69ea478b8640c120e5838f76be5e"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.2.0/illogical-0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4dbc0c9ed00fcd5182e3b2eec0870120e5ed6e66c5216e0fc675d64bbb7b1418"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.2.0/illogical-0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f4f50e86dbeed8e6da5d39937de1b5bd8b28fa4caae7abf3349024a33c3742bc"
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
