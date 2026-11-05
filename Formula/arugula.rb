# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.68.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.2/arugula-0.68.2-x86_64-apple-darwin.tar.gz"
      sha256 "3f0499a718a951eb2cfddd88b79a93f2b99e55e94ed1a9a6caaf5e0c334e4e3d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.2/arugula-0.68.2-aarch64-apple-darwin.tar.gz"
      sha256 "6d5ea54574d82f33411b120153ffd96482914a9b80f4d0c086b3e0f8baac316d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.2/arugula-0.68.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "239e345c60ddeae03af02b82907f1a6b4c496d042dc489c74feec7e4451e713d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.68.2/arugula-0.68.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c4a9e211c454d3e26478ee982b859a03cc5b1cc6d2c490db5248bafff8ea4afe"
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
