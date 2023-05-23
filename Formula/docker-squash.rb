class DockerSquash < Formula
  include Language::Python::Virtualenv

  desc "Docker image squashing tool"
  homepage "https://github.com/goldmann/docker-squash"
  url "https://files.pythonhosted.org/packages/6c/0b/3684b7e34c46045dda03b34be50392c689b23fa8788a0c0f7daf98db35d8/docker-squash-1.1.0.tar.gz"
  sha256 "819a87bf44c575c76d8d8f15544363a7a81ca2b176d424b67b39cd2cd9acc89e"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f4fc07066c611871f71e05e9ec7aed84a542577494557ac1a56590c1ca50afd1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3009a55eee38090629be78004125492dd3ca85819b13d978ce262527b17ef656"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3f156dbd6bae7ea98fab740b4a48e32387854c5fd7f3749ae2f4b77ec2bda10a"
    sha256 cellar: :any_skip_relocation, ventura:        "ac2029056458b4362ee8ef425dc50dda2d3c048f269c11ead1291e4211c812da"
    sha256 cellar: :any_skip_relocation, monterey:       "d34118730ff5d785f50662d5ae370b0a4d01dc646eb9c24a2ab64a4512dcfb01"
    sha256 cellar: :any_skip_relocation, big_sur:        "02ffb6771aef66706af6e98cab7ec5b53c1f0095018a0675948f5b38acdf7027"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8c3f565c7a0c9033d033c5aa7e2abfd562372ac6957a69b3e2bf90bd4a92929"
  end

  depends_on "python@3.11"
  depends_on "six"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/93/71/752f7a4dd4c20d6b12341ed1732368546bc0ca9866139fe812f6009d9ac7/certifi-2023.5.7.tar.gz"
    sha256 "0f0d56dc5a6ad56fd4ba36484d6cc34451e1c6548c61daad8c320169f91eddc7"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "docker" do
    url "https://files.pythonhosted.org/packages/d4/5f/48add223bfc02f7645b990418d1d3e01f6d4de7e6fcee31919f40129e893/docker-6.1.2.tar.gz"
    sha256 "dcc088adc2ec4e7cfc594e275d8bd2c9738c56c808de97476939ef67db5af8c2"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/b9/6c/7c6658d258d7971c5eb0d9b69fa9265879ec9a9158031206d47800ae2213/packaging-23.1.tar.gz"
    sha256 "a392980d2b6cffa644431898be54b0045151319d1e7ec34f0cfed48767dd334f"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/fb/c0/1abba1a1233b81cf2e36f56e05194f5e8a0cec8c03c244cab56cc9dfb5bd/urllib3-2.0.2.tar.gz"
    sha256 "61717a1095d7e155cdb737ac7bb2f4324a858a1e2e6466f6d03ff630ca68d3cc"
  end

  resource "websocket-client" do
    url "https://files.pythonhosted.org/packages/3f/f2/2624e12ef854ee667d92ac5dc7815932095e0852e5ff2b2bf57feda8a11b/websocket-client-1.5.2.tar.gz"
    sha256 "c7d67c13b928645f259d9b847ab5b57fd2d127213ca41ebd880de1f553b7c23b"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    ENV["DOCKER_HOST"] = "does-not-exist:1234"
    output = shell_output("#{bin}/docker-squash not_an_image 2>&1", 1)
    assert_match "Could not create Docker client", output
  end
end
