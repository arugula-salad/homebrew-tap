# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.45.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.45.0/arugula-0.45.0-x86_64-apple-darwin.tar.gz"
      sha256 "e72179ba78bb6c3e439aeca9fb70cbfb009c0a98e24ae9ee272fdda44407281f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.45.0/arugula-0.45.0-aarch64-apple-darwin.tar.gz"
      sha256 "6f7201770c0321acc9616ff6468b0339ee1724588b9761c76f1b764333e9b534"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.45.0/arugula-0.45.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e61a5c98452c79a35d913074e0c1c8624a310b3e3613a520fc589b1264f6277c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.45.0/arugula-0.45.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3806054516a31c67eea5ae7f6c1ba8e00d1c55eef47ed793bbb78173442911f1"
    end
  end

  def install
    bin.install "arugulad", "arugula"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        arugulad install
      It copies itself to ~/.local/bin, runs from there, and prints the
      next steps: where to open it, its logs, your phone (Tailscale) and
      Arugula control. Then, for Claude Code:
        claude mcp add arugula -- arugula mcp
      Docs: https://arugula.io/#install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arugulad --version")
  end
end
