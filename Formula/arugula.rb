# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.148"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.148/arugula-0.70.148-x86_64-apple-darwin.tar.gz"
      sha256 "c3548b01ba4898404ebae1ba179d5fd219ff0e225e442d204220fea80c33a428"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.148/arugula-0.70.148-aarch64-apple-darwin.tar.gz"
      sha256 "f6cf2944380fdf54245479fe5bc70d9db69815a761d3545e266edb49ff1473bb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.148/arugula-0.70.148-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8875429ab7e56bc952d8dc7760f619ad442d08cfbb2ea14f6c71c5320291211c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.148/arugula-0.70.148-aarch64-unknown-linux-musl.tar.gz"
      sha256 "55506a84e7f1b5e0dc6d2fda208fd836c602b961665eb522069ff3102a115c92"
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
