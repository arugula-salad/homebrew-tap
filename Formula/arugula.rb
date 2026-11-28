# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.155"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.155/arugula-0.70.155-x86_64-apple-darwin.tar.gz"
      sha256 "6673882db16558f960b35172ce9768e35a1ac49b4d1cea08add7caa856b74a72"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.155/arugula-0.70.155-aarch64-apple-darwin.tar.gz"
      sha256 "d90a89225cffdf486b92a4bf8ee76c83c5304bec093df967291ba95c49c9e0af"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.155/arugula-0.70.155-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6192328e50a8a00c06d93e33f239d66b0f76120b9f5cb1eaaf11427e2c3023d9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.155/arugula-0.70.155-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b4e0cf5ceed0273f346d284f48708807fa356789dcbc78e0b9331c7b03d13c0e"
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
