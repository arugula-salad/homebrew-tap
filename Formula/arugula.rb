# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.2/arugula-0.70.2-x86_64-apple-darwin.tar.gz"
      sha256 "7ef3de2ba931962af6e272c03a64349731b2470134a4067bc249c8a557785e01"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.2/arugula-0.70.2-aarch64-apple-darwin.tar.gz"
      sha256 "cfaf9e6a85f96623665d28ae283b42fe0de8111de1b5c5c7227ab3ed48e9adac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.2/arugula-0.70.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "22e49fb29b6644190d214fd97417a293007577e449f0aa498dcd505bfe681120"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.2/arugula-0.70.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0306b09f5bc541467cb6d8597add1bdb89870c70b26f716852376ca2dcc56a9a"
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
