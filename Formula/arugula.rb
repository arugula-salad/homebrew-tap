# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://illogical.widgets.wtf"
  version "0.26.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.26.0/arugula-0.26.0-x86_64-apple-darwin.tar.gz"
      sha256 "b612194ce0afa9e574f173fda115f91847e369969539cd32a4575f6ec06b6136"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.26.0/arugula-0.26.0-aarch64-apple-darwin.tar.gz"
      sha256 "3196654c636ba86dba70aa9c74909eaae5540885fa47cbe6ca9c6830bc1aefb9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.26.0/arugula-0.26.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0dfb692a6c3d96961df2f5a2276920f1f1ee5953407824f8126f576fef13f9cd"
    end
    on_arm do
      url "https://github.com/arugula-salad/illogical/releases/download/v0.26.0/arugula-0.26.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "44214639f9f56d6d9c5131c5f89d745b56227f260b459fbd179a488016ecf333"
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
      Docs: https://illogical.widgets.wtf/#install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arugulad --version")
  end
end
