# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.23.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.23.0/illogical-0.23.0-x86_64-apple-darwin.tar.gz"
      sha256 "cc94555d430622ad6c401971ef4d13c31298ddfebe97058bcc1a6138a6111f21"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.23.0/illogical-0.23.0-aarch64-apple-darwin.tar.gz"
      sha256 "442c9949ad4f4f5cbcfec733d8d3dff5e866d5845eac579605a46bbcdffccdfe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.23.0/illogical-0.23.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d14af2b483dbab1eaa711d41f84a234f115819d552b2e4a8d096740430e2bdbb"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.23.0/illogical-0.23.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "81823fa26184cf94ef7a09dba64b9fbfba759c116208eb5e896e95cb393af32a"
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
