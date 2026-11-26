# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.122"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.122/arugula-0.70.122-x86_64-apple-darwin.tar.gz"
      sha256 "017f3b342670e8b7a579180c1b8af48e58408dcb95e30d81dd6cbdeca9ff3f82"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.122/arugula-0.70.122-aarch64-apple-darwin.tar.gz"
      sha256 "79fef5ba9386c2ef3396175633d9133bd9e19884ebda6c660a22a4dfa53db5f7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.122/arugula-0.70.122-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fc5d5de95dad088f17a7cdd22f507361e3f48498b4b7fa2e220d57942e4dd6a4"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.122/arugula-0.70.122-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dc3c4d7e48c95f22262887bc1a15e8ec78223fec746f686c8e33e46c2156ad38"
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
