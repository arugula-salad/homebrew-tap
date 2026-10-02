# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.6.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.6.1/illogical-0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "d849122686b2fb51696ac545d7604aba406746675cbd61d772761038d6ec13a6"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.6.1/illogical-0.6.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6ccca5f85d6f148366d5919f85f54c1e7f90f839dfe07b056c0b62b0dc9aaf83"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.6.1/illogical-0.6.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2ce47294cd49bae95a55442e047b0cce211509b91d941337522435422dbf40e5"
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
