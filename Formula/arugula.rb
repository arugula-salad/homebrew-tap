# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.135"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.135/arugula-0.70.135-x86_64-apple-darwin.tar.gz"
      sha256 "fcecee98a974cd82dc2d5bb7c43e7c39fe8e46aee6af3c2e60eaa134f6847e17"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.135/arugula-0.70.135-aarch64-apple-darwin.tar.gz"
      sha256 "4c35159a1da3b5143bc18fbcb468a3ffb6a981cae1ced017436158648448959b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.135/arugula-0.70.135-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ad9392e5e3c70f8dfa4935a13f695ed46f3053255b847f228017f902fde5639a"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.135/arugula-0.70.135-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a16d7e4421cfa11afa5354afc06c7bf27120200af7de60c92646a78f796ca82f"
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
