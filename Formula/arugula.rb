# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.74"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.74/arugula-0.70.74-x86_64-apple-darwin.tar.gz"
      sha256 "78a840400994c50360300c5560df282583fb41bc1104b8aeccddc38bb0f22cc7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.74/arugula-0.70.74-aarch64-apple-darwin.tar.gz"
      sha256 "e9dab21a092d231f90e8773e25da87771c8c67f270b50dbb939601b7d240e15d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.74/arugula-0.70.74-x86_64-unknown-linux-musl.tar.gz"
      sha256 "504789f03da613b5b065cf056f2ddd6d4414cd1dc0d14f7b376e59ff8f34ac42"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.74/arugula-0.70.74-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d1104a980146d346d0ce59c1520bbdc82a469466472cba4cefaf64afef4300dc"
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
