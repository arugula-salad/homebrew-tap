# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.107"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.107/arugula-0.70.107-x86_64-apple-darwin.tar.gz"
      sha256 "ad0d14c770190a9034b0684c75968568e8b43eaec21abf3c69433a12db842e6a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.107/arugula-0.70.107-aarch64-apple-darwin.tar.gz"
      sha256 "8e66ac8266023e8d69b8a8d9403d09d6a1ad2cacf4e4db00b2743605fd84d014"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.107/arugula-0.70.107-x86_64-unknown-linux-musl.tar.gz"
      sha256 "296e684fcf05c384cde869cc1db2caaae6d87d6502d8ef07b32aa1a614139ea6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.107/arugula-0.70.107-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0d50bce159ad0d9a2e2a6b9b6a26a702af75ed2b2e9ca3a8d723b434e5d4a484"
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
