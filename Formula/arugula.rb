# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.16"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.16/arugula-0.70.16-x86_64-apple-darwin.tar.gz"
      sha256 "1f4191ed67fd40ba72901c9cc4d718aa96f3a4f4fdcba52ba3c70acea660ae1c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.16/arugula-0.70.16-aarch64-apple-darwin.tar.gz"
      sha256 "d74c6aaf6d039259b4507494a1a655d75b84cb7451190791f19eb673679b1613"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.16/arugula-0.70.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3fc7ae48675739e499a195c26243236e7fbc623dc8061c6d302edd85a07f1ada"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.16/arugula-0.70.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cf68b2f46b652560cb34ad1a1d6bb16b9a597b1741ccbe6c34f8787b6991b970"
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
