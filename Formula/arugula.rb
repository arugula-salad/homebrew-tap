# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.139"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.139/arugula-0.70.139-x86_64-apple-darwin.tar.gz"
      sha256 "eab5ca5a824938cb29675bfccadc3f6e43778fb377d51c2d02da5220d5dbdb81"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.139/arugula-0.70.139-aarch64-apple-darwin.tar.gz"
      sha256 "2f9bb7349e1b3e76ceed1fee0535c2a812b72d9ff4bdcc35a7a6b395eff4d06f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.139/arugula-0.70.139-x86_64-unknown-linux-musl.tar.gz"
      sha256 "561f84834a1af0d4c0b0915d33600e7394ed0ca8191647e7a095273a58f9d39a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.139/arugula-0.70.139-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bbd449978945c09dc2afa10666e7e07d4a56962904b9bc8556005b153b7467ca"
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
