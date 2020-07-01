# Copyright 2019 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Repository external dependency resolution functions."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _include_if_not_defined(repo_rule, name, **kwargs):
    if not native.existing_rule(name):
        repo_rule(name = name, **kwargs)

JINJA2_BUILD_FILE = """
py_library(
    name = "jinja2",
    srcs = glob(["jinja2/*.py"]),
    srcs_version = "PY2AND3",
    deps = [
        "@markupsafe_archive//:markupsafe",
    ],
    visibility = ["//visibility:public"],
)
"""

MARKUPSAFE_BUILD_FILE = """
py_library(
    name = "markupsafe",
    srcs = glob(["markupsafe/*.py"]),
    srcs_version = "PY2AND3",
    visibility = ["//visibility:public"],
)
"""

MISTUNE_BUILD_FILE = """
py_library(
    name = "mistune",
    srcs = ["mistune.py"],
    srcs_version = "PY2AND3",
    visibility = ["//visibility:public"],
)
"""

SIX_BUILD_FILE = """
py_library(
    name = "six",
    srcs = ["six.py"],
    srcs_version = "PY2AND3",
    visibility = ["//visibility:public"],
)
"""

# buildifier: disable=unnamed-macro
def skydoc_repositories():
    """Adds the external repositories used by the starlark rules."""
    _include_if_not_defined(
        http_archive,
        name = "bazel_skylib",
        urls = ["https://github.com/bazelbuild/bazel-skylib/archive/560d7b2359aecb066d81041cb532b82d7354561b.tar.gz"],
        sha256 = "0cf18d7ba964b6a4ef4b21d471e3541cd22f7594512d172274d86647a87a2ffe",
        strip_prefix = "bazel-skylib-560d7b2359aecb066d81041cb532b82d7354561b",
    )
    _include_if_not_defined(
        http_archive,
        name = "io_bazel_rules_sass",
        urls = ["https://github.com/bazelbuild/rules_sass/archive/8ccf4f1c351928b55d5dddf3672e3667f6978d60.tar.gz"],
        sha256 = "d868ce50d592ef4aad7dec4dd32ae68d2151261913450fac8390b3fd474bb898",
        strip_prefix = "rules_sass-8ccf4f1c351928b55d5dddf3672e3667f6978d60",
    )
    _include_if_not_defined(
        http_archive,
        name = "markupsafe_archive",
        urls = ["https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.23.tar.gz#md5=f5ab3deee4c37cd6a922fb81e730da6e"],
        sha256 = "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3",
        build_file_content = MARKUPSAFE_BUILD_FILE,
        strip_prefix = "MarkupSafe-0.23",
    )
    native.bind(
        name = "markupsafe",
        actual = "@markupsafe_archive//:markupsafe",
    )

    _include_if_not_defined(
        http_archive,
        name = "jinja2_archive",
        urls = ["https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.8.tar.gz#md5=edb51693fe22c53cee5403775c71a99e"],
        sha256 = "bc1ff2ff88dbfacefde4ddde471d1417d3b304e8df103a7a9437d47269201bf4",
        build_file_content = JINJA2_BUILD_FILE,
        strip_prefix = "Jinja2-2.8",
    )
    native.bind(
        name = "jinja2",
        actual = "@jinja2_archive//:jinja2",
    )

    _include_if_not_defined(
        http_archive,
        name = "mistune_archive",
        urls = ["https://pypi.python.org/packages/source/m/mistune/mistune-0.7.1.tar.gz#md5=057bc28bf629d6a1283d680a34ed9d0f"],
        sha256 = "6076dedf768348927d991f4371e5a799c6a0158b16091df08ee85ee231d929a7",
        build_file_content = MISTUNE_BUILD_FILE,
        strip_prefix = "mistune-0.7.1",
    )
    native.bind(
        name = "mistune",
        actual = "@mistune_archive//:mistune",
    )

    _include_if_not_defined(
        http_archive,
        name = "rules_java",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_java/archive/7cf3cefd652008d0a64a419c34c13bdca6c8f178.zip",
            "https://github.com/bazelbuild/rules_java/archive/7cf3cefd652008d0a64a419c34c13bdca6c8f178.zip",
        ],
        sha256 = "bc81f1ba47ef5cc68ad32225c3d0e70b8c6f6077663835438da8d5733f917598",
        strip_prefix = "rules_java-7cf3cefd652008d0a64a419c34c13bdca6c8f178",
    )
