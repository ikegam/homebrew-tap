# Homebrew formula for ikegam/homebrew-tap (installs the prebuilt release binaries).
# Version and checksums are filled in by packaging/update.sh on release.
class PlamoTrans < Formula
  desc "Local translation as a Unix filter: PLaMo 3 Translate on llama.cpp, no server"
  homepage "https://github.com/ikegam/plamo-trans"
  version "0.1.1"
  license all_of: ["BSD-4-Clause", "MIT"]

  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/ikegam/plamo-trans/releases/download/v#{version}/plamo-trans-#{version}-macos-arm64.tar.gz"
      sha256 "d810fdb6d8c9e305087a44aa0ae64c343eb096bdc734d3cf0bd17f9af966f1ba" # macos-arm64
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ikegam/plamo-trans/releases/download/v#{version}/plamo-trans-#{version}-linux-x86_64.tar.gz"
      sha256 "b353f6b3aed001d95e99fffaea4dd97cfcec4ff1b1ea69d9be8a11b5e2ec5a3d" # linux-x86_64
    end
    on_arm do
      url "https://github.com/ikegam/plamo-trans/releases/download/v#{version}/plamo-trans-#{version}-linux-arm64.tar.gz"
      sha256 "6913ab922a5361b7e09b1f8d50014bb1bf91ef2d0ecfbf91b782e00feb5b47ec" # linux-arm64
    end
  end

  def install
    bin.install "trs"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      The model is not included. Read the PLaMo Community License, then download one:
        trs --download 8b      # 5.3 GB, the default
        trs --download 0.8b    # 0.6 GB, for -ff
      https://huggingface.co/pfnet/plamo-3-translate-31b-GGUF
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/trs -V")
  end
end
