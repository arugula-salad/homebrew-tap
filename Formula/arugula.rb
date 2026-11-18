# The Arugula formula, which each daemon release commits to the
# arugula-salad/homebrew-tap repo through chant's homebrew target
# (release/daemon/chant.config.ts). Don't edit the copy there.
# `scripts/release formula` puts the version in the tarballs' names, and
# chant fills in the version, each tarball's URL and its SHA-256.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.70.41"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.41/arugula-0.70.41-x86_64-apple-darwin.tar.gz"
      sha256 "271a29f8a6a16999e92435dd275e773ed59c3a5a4a61d661c167740e9c3c2461"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.41/arugula-0.70.41-aarch64-apple-darwin.tar.gz"
      sha256 "e695d60414c381bf4678d73fcdc492a2a9d67ce026b820a75532bb5151f8528f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.41/arugula-0.70.41-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b9de2d51aa1325cb685955893719343895a5a00acf4ad26052f40889b36acb75"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.70.41/arugula-0.70.41-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2d9145ef6a418d906c67686d9a4796a53758b152483e35de6d670bf78a26b5b1"
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
