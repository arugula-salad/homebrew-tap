# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.20.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.20.0/illogical-0.20.0-x86_64-apple-darwin.tar.gz"
      sha256 "bde3a1e91f4ae00b20c67677ade704a4c639196e1b3dd8bbfabae6b7cb3673cd"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.20.0/illogical-0.20.0-aarch64-apple-darwin.tar.gz"
      sha256 "11017453bb5d587d78d6b155eb10276b96621c8af96221e498bdccd6e54e322b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.20.0/illogical-0.20.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1c674425f22cd8db86c139244ba1d0efbc675dd3d6659b9de4af2eb58581d884"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.20.0/illogical-0.20.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5a81f3b81439378df05b4eae727bf8e02957b646b6a7dc1c71dcfeb90b6ea418"
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
