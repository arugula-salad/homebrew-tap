# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.4/arugula-0.70.4-x86_64-apple-darwin.tar.gz"
      sha256 "79f460f83e71c5fa39c85fde907cfcd22522862fd163ce1a6f635b9fb59c2512"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.4/arugula-0.70.4-aarch64-apple-darwin.tar.gz"
      sha256 "147c9846a2334c8a2449daccd6049d426ec17f79642a177486aeb5a0bd14377b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.4/arugula-0.70.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e18f4bef8ce10d8e0ae9fa541a8ccdd5f3153999fe2c81a51391318e74f980ba"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.4/arugula-0.70.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b73b2544c3be62cb689f699faaa295790935041d3f821fd737e9a8e4161165e8"
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
