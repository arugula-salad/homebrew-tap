# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.29.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.29.0/arugula-0.29.0-x86_64-apple-darwin.tar.gz"
      sha256 "476e47ceb245aaec394b2e107966f33b6187efd08cbe7db511aa608c95a771b0"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.29.0/arugula-0.29.0-aarch64-apple-darwin.tar.gz"
      sha256 "3ed11328c9d74deb475b9b804b8d779c4383a05254213d0fdde3aab288da0002"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.29.0/arugula-0.29.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "520d36de6f55380c3d33726050cff29a8028a1ace53332f6df1d9bf93c6c345e"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.29.0/arugula-0.29.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d76a9d145f3f98589c6190ddf3c7059afb0ce9abbf89e9a5e63f5b2429b4691e"
    end
  end

  def install
    bin.install "arugulad", "arugula"
    # The old names, for hooks and scripts that call them (#505, drop in
    # #508). The formula was `illogical`; the tap's formula_renames.json
    # moves its installs here.
    bin.install_symlink "arugulad" => "illogicald"
    bin.install_symlink "arugula" => "illogical"
  end

  def caveats
    <<~EOS
      Start the daemon as a service (a launchd agent on macOS, a systemd
      user unit on Linux), and again after each upgrade:
        arugulad install
      Coming from illogical: that replaces the illogicald service with
      arugulad's, keeping your panes, state and settings.
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
