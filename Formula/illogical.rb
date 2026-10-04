# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.13.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.13.0/illogical-0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "bf6b104c36fca9da37cf97dca0ce7d15ca7c954256e3aa1df6579daf2fbb446c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.13.0/illogical-0.13.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d44241f72e5b50136fc72506035d873d126be39e92436f3f6111e6f1a85fab0b"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.13.0/illogical-0.13.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a3eeca6781e7344bf49019bc5c136cadacd1ed67bad696aa7b0f31b387150b69"
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
