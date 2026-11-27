# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.144"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.144/arugula-0.70.144-x86_64-apple-darwin.tar.gz"
      sha256 "baddc26ccbf0297fa9a2211842f3dd9d111005b7963d4e92e5c34340f46f1801"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.144/arugula-0.70.144-aarch64-apple-darwin.tar.gz"
      sha256 "da91375b6eed110ee8b553f735a409146d376173823369f97e3a4eddc66884e8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.144/arugula-0.70.144-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f086734e1b772352a4daeff7f457307f3f78ca700f7283414aa33cf3760520de"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.144/arugula-0.70.144-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bdb5019bbea3cd97408148b8d03becb5f4936a62980d7ca0b40e6d342da99ea4"
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
