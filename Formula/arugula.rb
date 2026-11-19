# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.47"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.47/arugula-0.70.47-x86_64-apple-darwin.tar.gz"
      sha256 "e366f91725d91050043e95bb822d43148afada7fba146a5145ab3cba00172ad5"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.47/arugula-0.70.47-aarch64-apple-darwin.tar.gz"
      sha256 "3d97a91f21a1d1e2a17c4657dc48508651e3c48e5b85739d382626125f64bf2e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.47/arugula-0.70.47-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d1c6b67ec3903bf5a048c9851bd16d6fa9d442537531fc86c9a6355cf5629fc3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.47/arugula-0.70.47-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fcd417337ae7744007d7beac7c44b88da53e0780f52d381b7ae357c3be68e8e6"
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
