# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.109"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.109/arugula-0.70.109-x86_64-apple-darwin.tar.gz"
      sha256 "5df5cf30690770292b7b0da088a08a9e7a42cf6de7acd8c2653357c2ba9296f2"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.109/arugula-0.70.109-aarch64-apple-darwin.tar.gz"
      sha256 "965b529ea1b58154a6bd09ef670aa6d2ca7bfacef3895a160d24f38e9b509609"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.109/arugula-0.70.109-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8a6c847a841521be3171fdf484fedd0f605240aa68f119ab1096e47a3e8ae690"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.109/arugula-0.70.109-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fcd44bc18ec03dc7cffd9cda94ca72555f5c2e441198ca2c0561a861df3d0982"
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
