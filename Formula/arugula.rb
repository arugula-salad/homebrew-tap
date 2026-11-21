# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.66"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.66/arugula-0.70.66-x86_64-apple-darwin.tar.gz"
      sha256 "9d3c2d0b70e6b71ca4a56216dfb214cee47962f582720029d669b8b487df4182"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.66/arugula-0.70.66-aarch64-apple-darwin.tar.gz"
      sha256 "4ca87e17d8b70c2e73bf0547125f608145bf60c693339888bb4865d432b72fbe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.66/arugula-0.70.66-x86_64-unknown-linux-musl.tar.gz"
      sha256 "88566a9a23d35a9f295cf464af3efafb5de299b497d7b49c32262d88161edba3"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.66/arugula-0.70.66-aarch64-unknown-linux-musl.tar.gz"
      sha256 "de1d71532f1379819934509400808238f66c29834beed7ea7b58a5cdfaee6078"
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
