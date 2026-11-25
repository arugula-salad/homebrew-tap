# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.108"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.108/arugula-0.70.108-x86_64-apple-darwin.tar.gz"
      sha256 "5f8254d9d16d13a5daa191879b7d9ca8bb43e7486703f20bbd2faf586da3e093"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.108/arugula-0.70.108-aarch64-apple-darwin.tar.gz"
      sha256 "602db8be6ebc1fceb5856624317b1a89b2dcabb9325915e0ba9d5b4846e1830b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.108/arugula-0.70.108-x86_64-unknown-linux-musl.tar.gz"
      sha256 "065842d235beef3bf45783e5d72773bcff45b3b110790315cec96c59e385eec3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.108/arugula-0.70.108-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6ac0afe8e88e82101e159733fc74236cdac577fab29369a2fdb50355c8d14513"
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
