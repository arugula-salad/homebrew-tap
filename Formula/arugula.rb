# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.130"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.130/arugula-0.70.130-x86_64-apple-darwin.tar.gz"
      sha256 "ef44373ee9f899be109d703100eb359e20b43526750c4c7b58ce12fd064cb91c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.130/arugula-0.70.130-aarch64-apple-darwin.tar.gz"
      sha256 "3535cd2617c06aa2efa184a505bc0fb7d6e452e662e4c9dfb2e921636460e2a3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.130/arugula-0.70.130-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f976250bad2e95b19bf7867fe265e0db47f9f4f33020f84b38767f12b108bfc9"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.130/arugula-0.70.130-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b5da9411ff154ee122536bdc33b038bd8c5cb12709a5846f9e7eae8bb9d2bf33"
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
