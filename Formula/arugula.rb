# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.36"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.36/arugula-0.70.36-x86_64-apple-darwin.tar.gz"
      sha256 "a5e2c52ae11efe0e7982352da1aec7caa3343df1c7bb265e6f8c90834eb621b1"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.36/arugula-0.70.36-aarch64-apple-darwin.tar.gz"
      sha256 "6f74eb73d83793566f8b2e90352d89b0089c20fd9140af0d24ffe4fed06458fa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.36/arugula-0.70.36-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ccf201172ea9bcd2c9f009590b9fb2da73b2b77f8f9f25828d861061c45e3987"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.36/arugula-0.70.36-aarch64-unknown-linux-musl.tar.gz"
      sha256 "74bc20760692900bef4bac262ffb0e490796044863f25c0c81009a8d4c865463"
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
