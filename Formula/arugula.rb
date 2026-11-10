# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.10/arugula-0.69.10-x86_64-apple-darwin.tar.gz"
      sha256 "05ecf771833ab4a78f1f18c5102aed905937e59238525e18645c3b69f0b7761c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.10/arugula-0.69.10-aarch64-apple-darwin.tar.gz"
      sha256 "35b2cd077341a24ae455264b931ee0e221ccbdcd5a78bdda921b251f27f25cbd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.10/arugula-0.69.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7b62fb296ddd9b1ef3ef0920cb68c9bd3faa3641df28fd8912aec526e60dc653"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.10/arugula-0.69.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "252878dc213bac9a1d7535f25866d7cb216f47285b486b2d1beb971a941d25a9"
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
