# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.160"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.160/arugula-0.70.160-x86_64-apple-darwin.tar.gz"
      sha256 "2c7a47a2f20d0ea613de2ac04c48bb9a66c7ec4dc047125f942dd8a648dce834"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.160/arugula-0.70.160-aarch64-apple-darwin.tar.gz"
      sha256 "d2742ed21a3afd3d1ace80cef61a05ffef34716fe04049ba5541b5f97f9d22e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.160/arugula-0.70.160-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e88242380985e2e817f24fecef421019b4aa1a3310cdd09aa80c57822568b88c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.160/arugula-0.70.160-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2fa8ae8a01aaef1d726a2d520c721b1be0468ee4b61bd057376aa7c4c2314764"
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
