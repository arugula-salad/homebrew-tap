# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.72"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.72/arugula-0.70.72-x86_64-apple-darwin.tar.gz"
      sha256 "5a2295c929688a70173260bbe5fa935af4304eeac7773782db6ee3ea86f99db7"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.72/arugula-0.70.72-aarch64-apple-darwin.tar.gz"
      sha256 "5731f462741a9c1581cf2dc94013ad356690c56db9ba190ab9e6d45e405250c8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.72/arugula-0.70.72-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ce396522cd124ac5d239f4e751e111f2a995c8d96d66c0925d6ae9c3595bc626"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.72/arugula-0.70.72-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9527eeb0874d803d19779bb59aba6927f3df906ca1d392355659770405dea5fe"
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
