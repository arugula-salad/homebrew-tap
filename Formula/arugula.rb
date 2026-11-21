# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.67"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.67/arugula-0.70.67-x86_64-apple-darwin.tar.gz"
      sha256 "a9bdd0030e58bd7453fd56a8dab1abb6e05d049d9acbc04f9eda34463bd40a3c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.67/arugula-0.70.67-aarch64-apple-darwin.tar.gz"
      sha256 "48448599753c55ff96305218b5ea17b33c28efb22c5e81006f2dc5be7f2ed51b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.67/arugula-0.70.67-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7f38309fb6ba352e041996bbe6dfaca0ac5758c2126068bf6f77177702b2f015"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.67/arugula-0.70.67-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5a5731b1b82792bd54b1c4dff57a5707c91a59f0603e03801ac011027717a309"
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
