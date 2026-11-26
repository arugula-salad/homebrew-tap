# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.125"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.125/arugula-0.70.125-x86_64-apple-darwin.tar.gz"
      sha256 "bcc9c1dfad156e3401bcca30422a44b5eadceb44c62f4ba592587edb036f949d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.125/arugula-0.70.125-aarch64-apple-darwin.tar.gz"
      sha256 "501a43bddb52a44122de2b6ada17aca56602a7df6800cf76b2028fbeb6bac254"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.125/arugula-0.70.125-x86_64-unknown-linux-musl.tar.gz"
      sha256 "18f603aca6f17676e90161d3789343d2350f0767f7922bcead3d784eb4323362"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.125/arugula-0.70.125-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6f74a9fde6dd0e37bffe889284ea85360ad604446f36240f1dd343905169ef76"
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
