# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.117"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.117/arugula-0.70.117-x86_64-apple-darwin.tar.gz"
      sha256 "75e7c455c3df938d7498878389729aa9fbef0a41390bba955eac7fcd65f8e538"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.117/arugula-0.70.117-aarch64-apple-darwin.tar.gz"
      sha256 "8a032bcb7915ca069f6b9d16295abeebb2a5d7360048ab9a407cf9653269b9b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.117/arugula-0.70.117-x86_64-unknown-linux-musl.tar.gz"
      sha256 "acd71f3ff5bb6d3ea6549fa2e5c1079fdfdcf87072a0c55c8456d454b4bb25ea"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.117/arugula-0.70.117-aarch64-unknown-linux-musl.tar.gz"
      sha256 "95f967a49f6906d8763185f6d46c6109c7efd356dea3676c3cf730152d0005de"
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
