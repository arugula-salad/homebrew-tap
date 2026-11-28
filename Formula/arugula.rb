# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.154"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.154/arugula-0.70.154-x86_64-apple-darwin.tar.gz"
      sha256 "ef9247d7aa8a731960e7b64856b1442afb739ddae0a4d84e4c5b200890135417"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.154/arugula-0.70.154-aarch64-apple-darwin.tar.gz"
      sha256 "3d7b6a1966dc9f8eb69a4ed47c0da365ace1577e10c5d493a0299e14d04ceda5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.154/arugula-0.70.154-x86_64-unknown-linux-musl.tar.gz"
      sha256 "27d29f51395a7da1ac54a210dd7a212c1811c126cff3e7c1117ad07dc9d23e76"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.154/arugula-0.70.154-aarch64-unknown-linux-musl.tar.gz"
      sha256 "284b857cfe28c6abb441d4e670f379587d412c77c49b1674c7cdbdab0fafc53c"
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
