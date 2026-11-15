# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.15/arugula-0.70.15-x86_64-apple-darwin.tar.gz"
      sha256 "b08576b513c0960e64ae0b3ab383ff59a5aedb0635712648b5a53d2c2ecfd94e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.15/arugula-0.70.15-aarch64-apple-darwin.tar.gz"
      sha256 "e56c79957da0e084cc2a56718b9ba3f86f5922d80f80d2e468d95946dda44f36"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.15/arugula-0.70.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1ae49f0a667b11a66645307429a33177a406a07b62193d686d82ca3fa3d77ed1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.15/arugula-0.70.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bb130fcaacbb781b188226987796bebc7aa38b3251f1ef3724636806ea1bcd55"
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
