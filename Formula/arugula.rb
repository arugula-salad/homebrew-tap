# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.158"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.158/arugula-0.70.158-x86_64-apple-darwin.tar.gz"
      sha256 "05511fce99ad1f40d45c7d8668aa9db900ec334d9676e043477058b2df31e460"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.158/arugula-0.70.158-aarch64-apple-darwin.tar.gz"
      sha256 "c8047a8478d86a03203dd730e6dfa6cc8fcd0fffbe487dc7c3211e386bd61f70"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.158/arugula-0.70.158-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c61847d202c06612625b6096561e92f0c81da8c26c8ab90bb3f2a97c4c5478d9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.158/arugula-0.70.158-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f4dcf86f58566f70768258d6f058b938a93cb34cb7751917859ef5aa3bb3e313"
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
