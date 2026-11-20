# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.55"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.55/arugula-0.70.55-x86_64-apple-darwin.tar.gz"
      sha256 "ddaa41725cd9b30a9e6f6c1bef68166b12fabeb6ff5bbb96c394e86cb5bea95c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.55/arugula-0.70.55-aarch64-apple-darwin.tar.gz"
      sha256 "6c8619172f2ddbe323c61c10cd3697ae1e3b46d063a666f35e944fa26a6b3abb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.55/arugula-0.70.55-x86_64-unknown-linux-musl.tar.gz"
      sha256 "59d556302c7135151a46d38a6ca462c6f7d421734294381a82feb8ab0bf22c1f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.55/arugula-0.70.55-aarch64-unknown-linux-musl.tar.gz"
      sha256 "af4331879933830532e233f0ac8305158207868e4deb62e596e71e2f73860333"
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
