# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.83"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.83/arugula-0.70.83-x86_64-apple-darwin.tar.gz"
      sha256 "068cec262f60d3a069479499dbc50c0b0f3881db5e0a864f8e4e453c28a3aa39"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.83/arugula-0.70.83-aarch64-apple-darwin.tar.gz"
      sha256 "0de525695c62de7c5103fdd34e72df03a1bb9714bb8cf49fc4dc7a6267bee4d4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.83/arugula-0.70.83-x86_64-unknown-linux-musl.tar.gz"
      sha256 "081f0b675ff20f35f4727f85b192436cee7ee02a315215cfe5676adbff35a5a1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.83/arugula-0.70.83-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4fb06dba9bae672c99693cebd8714594f72e7d89f270cd7a37086000914efa06"
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
