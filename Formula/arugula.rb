# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.86"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.86/arugula-0.70.86-x86_64-apple-darwin.tar.gz"
      sha256 "c6f8ee07eb14706d66553923edc832d5af36a06475ae962a9220090e3d15eb17"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.86/arugula-0.70.86-aarch64-apple-darwin.tar.gz"
      sha256 "77415a734deb9797142f868b207824945b7b89bd062726729bb7e7bc32d2166b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.86/arugula-0.70.86-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a1f8cbc4ca1c11bdcc6b30e50f39a66dc6b3bc595d1a1c266f2a565ff1cc2581"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.86/arugula-0.70.86-aarch64-unknown-linux-musl.tar.gz"
      sha256 "18fb046a393f5fc5248ddf314c1476b9c3ce7b6a94114efbd2f0d9361b6fb51f"
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
