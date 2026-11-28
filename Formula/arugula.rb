# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.153"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.153/arugula-0.70.153-x86_64-apple-darwin.tar.gz"
      sha256 "fd5589c2909b6e53d201d9fc76be49ce062aa2cad6e7ad553d76af77009e710e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.153/arugula-0.70.153-aarch64-apple-darwin.tar.gz"
      sha256 "da8daf668770c781fe1d1c62a881448a74bebcd5bdd445b339037661a0dcbc82"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.153/arugula-0.70.153-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b8144a707a29a11f6c657c8fbe88f59968eda23a52dbeeb164252897fd2d2e0c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.153/arugula-0.70.153-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9ec3ad2a94e3bfd5924a31d259205e10ccbdcf774cf119a538a34447478c2127"
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
