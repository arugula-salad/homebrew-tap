# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.63.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.0/arugula-0.63.0-x86_64-apple-darwin.tar.gz"
      sha256 "a791c403f817d32848de2d17e6a45db8c9ecbd0d51b5c2652b4280cfca43e598"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.0/arugula-0.63.0-aarch64-apple-darwin.tar.gz"
      sha256 "fe63397332ae1c73cd6a542276161742c5662661afe78f7b93eade03271e3291"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.0/arugula-0.63.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "aef7e0e8be9d162436a0c3be2bc715df1fd9ea9522eb5d7c4321aa28b3731722"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.63.0/arugula-0.63.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eb261cefaee8b183a549617d9c47e393900d184a9e1eb8d16e1048473c320d9d"
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
