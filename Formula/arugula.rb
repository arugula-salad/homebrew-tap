# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.101"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.101/arugula-0.70.101-x86_64-apple-darwin.tar.gz"
      sha256 "f8a1c62f15da623fd218959f3cc5581c9362f3330fb42a9a781eb3f75cfeebe6"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.101/arugula-0.70.101-aarch64-apple-darwin.tar.gz"
      sha256 "232d823859c6957ac70bb81d55173e4955a213848768910e8e91eff81e7e8a55"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.101/arugula-0.70.101-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0396a889fa25c49b4e868273fb02eb21fa10e8218e833d051706784db247f47e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.101/arugula-0.70.101-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c505e1a1fe2f9f4866bf25fea92e5eaf8dd83bd9ec0f9c7edfa24516b8d6b737"
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
