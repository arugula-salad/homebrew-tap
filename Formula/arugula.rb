# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.18"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.18/arugula-0.70.18-x86_64-apple-darwin.tar.gz"
      sha256 "c789ba2bdb258d079df4cd5817b2ebc799f93a227f29f2a85d254ae2305ad9be"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.18/arugula-0.70.18-aarch64-apple-darwin.tar.gz"
      sha256 "5629648372ce8849b8c5723ba56a888d4fdcb46d68a8857b88f3285772f30c07"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.18/arugula-0.70.18-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0e8c10a4dd360960adbfcf2d54c9d23d58ee8085051873ebae5d635f7c581761"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.18/arugula-0.70.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "81e3d14114033da7321c006f188cd78132282389ec91c1acd61da4ded1e9d551"
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
