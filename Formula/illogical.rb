# The illogical formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Illogical < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.21.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.21.0/illogical-0.21.0-x86_64-apple-darwin.tar.gz"
      sha256 "10ccef264966327b71b62d97771b5ea168567d1f9c9203b37ce202e77f8698bb"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.21.0/illogical-0.21.0-aarch64-apple-darwin.tar.gz"
      sha256 "83b8c8b1f53c54b784df9ca98835c3cf9ced10d8b6dbfbe259f3ba79468c2fa5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.21.0/illogical-0.21.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f1fcfb37668fdbf4aa5df288393a9759289ac7f2a3dffb20940525739a63fd83"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.21.0/illogical-0.21.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f873b0f9f7eae2d29d654c5ad9547ce2cba8a3d4f80a76317b2bf5a5acabf151"
    end
  end

  def install
    bin.install "illogicald", "illogical"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        illogicald install
      It copies itself to ~/.local/bin, runs from there, and prints the
      next steps: where to open it, its logs, your phone (Tailscale) and
      illogical control. Then, for Claude Code:
        claude mcp add illogical -- illogical mcp
      Docs: https://illogical.widgets.wtf/#install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/illogicald --version")
  end
end
