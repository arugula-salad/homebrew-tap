# The Arugula formula, written by scripts/release into the
# arugula-salad/homebrew-tap repo on each release. Don't edit the copy there.
class Arugula < Formula
  desc "Terminal multiplexer whose sessions outlive the window, the daemon and the reboot"
  homepage "https://arugula.io"
  version "0.26.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.2/arugula-0.26.2-x86_64-apple-darwin.tar.gz"
      sha256 "470ef4c202534e7d232c3a49b9a2b71967c6511384209a131b1cd96f42c0c94f"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.2/arugula-0.26.2-aarch64-apple-darwin.tar.gz"
      sha256 "40acc96d025ca5f104d96a582a45776ce37e6c8d0cbaaeede47f0850f2d96b41"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.2/arugula-0.26.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "02a28c17f6d8663fe918e5381d29a436a632ae3246940fcfe41217043347ea0d"
    end
    on_arm do
      url "https://github.com/arugula-salad/arugula/releases/download/v0.26.2/arugula-0.26.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8d297fe0b076a604c6e3aa79d0e624f355772a8d5939b2a78e150d18ad85394f"
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
