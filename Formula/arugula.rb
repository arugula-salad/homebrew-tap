# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.26.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.1/arugula-0.26.1-x86_64-apple-darwin.tar.gz"
      sha256 "5682214c44859119ef030c9519a615218782e072348ad76d76f7309d739cb5e8"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.1/arugula-0.26.1-aarch64-apple-darwin.tar.gz"
      sha256 "cb7c6e9143fde5306991adf2cf1b42b40b8438216c8c27223358c03f07ed2f4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.1/arugula-0.26.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d1ae6c6be487172312ea1ec5896f7b6131f5ce5e2fcbd9141152848974154e0c"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.1/arugula-0.26.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7e168ea64d95d8d0dd2cb7f8aa942606dfa074a02d399e3d66cbfad094f389f7"
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
