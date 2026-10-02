# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.3.0/illogical-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "525aa7f15406055e5443e2ce663ea72ce029519fa9627884d40bb0de3e71019f"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.3.0/illogical-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7b772b7c8f9ae884c57489e76783f7016759641d45dee92435c727dfa708669f"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.3.0/illogical-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2c7f560479ac2c1ca41e8032e71b4caf9de460d26a7fc5996814af07f2380458"
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
