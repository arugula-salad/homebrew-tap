# The illogical formula, written by scripts/release into the
# jhgaylor/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.5.0/illogical-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "47cfc37357602d44dbfe3c11d4a2c3e47e4d661c6da27d665ba1edae44cb8b7c"
    end
  end

  on_linux do
    on_intel do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.5.0/illogical-0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ea4cbe518312402930a2df5b456f54de04fd5962bc76d4dbb9ae0ec661191df9"
    end
    on_arm do
      url "https://git.inevitable.fyi/jhgaylor/illogical/releases/download/v0.5.0/illogical-0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "94bddf7842195eaa130074ae053c42441a76bd06e2148b54dfb04103ffe57f70"
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
