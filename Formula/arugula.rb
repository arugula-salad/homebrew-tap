# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.69.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.15/arugula-0.69.15-x86_64-apple-darwin.tar.gz"
      sha256 "9a009e5c16138525dfe6eb67a39eee6d03bde14145066f3ad089407236772737"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.15/arugula-0.69.15-aarch64-apple-darwin.tar.gz"
      sha256 "87e50743cae4fa8655b5bb1730c136b0243d81133a13a05d215c83d8f2e4a03c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.15/arugula-0.69.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2a676bb7d5709a28ecdda364ed0600b7592a20edf594e8bf88cddabb7120b742"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.69.15/arugula-0.69.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d75a7a4426ffd8088721628d8cb0cb21e10aa36aeb791d6f99cda8f7d9244429"
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
