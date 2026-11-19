# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.53"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.53/arugula-0.70.53-x86_64-apple-darwin.tar.gz"
      sha256 "9dcf7373c77e18753c9b13b0d6716ad86b93d47f312fd300771f286f23306343"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.53/arugula-0.70.53-aarch64-apple-darwin.tar.gz"
      sha256 "4ec9daee826bd3b4aa2cb39764d311a2ff6b12b0428b791276fc918601a76bad"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.53/arugula-0.70.53-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8763a88ea0076a806667ec146d69f88e2bc28bf45738b4b460f867a49851c43e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.53/arugula-0.70.53-aarch64-unknown-linux-musl.tar.gz"
      sha256 "812827c58b7dd2a7d8ffda5f870a7f68314b29f5e35c8120530562a2736428ff"
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
