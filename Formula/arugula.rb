# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.46"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.46/arugula-0.70.46-x86_64-apple-darwin.tar.gz"
      sha256 "832937199a3acc3a5d27bb5b5156a0d41fa84698d7dc64b318fd03284d7ae205"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.46/arugula-0.70.46-aarch64-apple-darwin.tar.gz"
      sha256 "6307ba0f3292cc3fe2d442dc576571b02a70dd6992a2b35be9ffe63e3b30dc54"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.46/arugula-0.70.46-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9ec8aa21e1813577021f62848cb6b2cbf7472c152fcbf5355dde009f63ea1d21"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.46/arugula-0.70.46-aarch64-unknown-linux-musl.tar.gz"
      sha256 "89783605effebc05287b7bd48cef1db4b2807e647ebadc0c33b1077d58ba5886"
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
