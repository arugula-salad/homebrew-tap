# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.24.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.24.0/illogical-0.24.0-x86_64-apple-darwin.tar.gz"
      sha256 "92f0eb507ad90389253bf36bc9fe1030a278dfaa289bb515f64fb023ccf36068"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.24.0/illogical-0.24.0-aarch64-apple-darwin.tar.gz"
      sha256 "b688ae1dc2ab44a5c290d19f834cde4e8cc547e3b52622d2484fbd6085b8f798"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.24.0/illogical-0.24.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6ac201a998994aa06b9c517a4d4ef11d27f3caf7ee6473e4f3909005ba05245f"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.24.0/illogical-0.24.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "02a4a3da17a0b9135a05d9e1b2f5c5a490ede12206bf7bf89599e7e6dab62d82"
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
