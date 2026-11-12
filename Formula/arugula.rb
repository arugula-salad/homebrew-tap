# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.19"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.19/arugula-0.69.19-x86_64-apple-darwin.tar.gz"
      sha256 "9fe929c7da2c89b9313ed3ee35d15e00cbbd8776cdb3e2fbc4cd78db9f78f810"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.19/arugula-0.69.19-aarch64-apple-darwin.tar.gz"
      sha256 "32b964ac2c0ec19399f1a24beee4a68444b9a9c4a6ca3bfb691f9f38d0c0573b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.19/arugula-0.69.19-x86_64-unknown-linux-musl.tar.gz"
      sha256 "68ce7a9a82af1243703954f7826b8b43e5bbfc2221e1b6a8ee791d8bad786537"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.19/arugula-0.69.19-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c5bac002b1c4a3b19a58cf9081e9cccf0a22f09651fea22ff509736606256a95"
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
