# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.7/arugula-0.69.7-x86_64-apple-darwin.tar.gz"
      sha256 "ef480e9c5b2036316e0bad4d567e76b399fc66bc8111df148c9df3b1af808371"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.7/arugula-0.69.7-aarch64-apple-darwin.tar.gz"
      sha256 "176ebbef4bd7840bb6c435166c9936ef1d3a023b717613bbd14b6f4370f335ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.7/arugula-0.69.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ce0313f7eb0a0e3b2e45d4e9aa458b3a8ed85543e49e1c1219558b0a7d07505d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.7/arugula-0.69.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8f65adad2a1e6993f76eff3d18d572a8feb0466df10d6a03d3eee527772cc840"
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
