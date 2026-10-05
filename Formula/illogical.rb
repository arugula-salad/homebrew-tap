# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.18.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.18.0/illogical-0.18.0-x86_64-apple-darwin.tar.gz"
      sha256 "96029a5a86c459612bcfade4d3fa69d409584b3795ba228e1c89313ce3c9d20d"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.18.0/illogical-0.18.0-aarch64-apple-darwin.tar.gz"
      sha256 "b07e566076ce53495eefa873e77be795c537a24b4f365eedee9e16ffd0879557"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.18.0/illogical-0.18.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cf97618ec90b592c4912a23ffe7915f241c4a1d132c4392acdf00f7a295a70fb"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.18.0/illogical-0.18.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0d947a3779680d4a6b73b18b02035e2a72c2b99151ccb5266e5cb531c5854ec2"
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
