"""
SPDX-License-Identifier: Apache-2.0
Copyright (c) 2024, Ampere Computing LLC
"""

from .issue import Issue
from ..localization import _


class ArchSpecificBuildOptionIssue(Issue):
    def __init__(self, filename, lineno, opt_name):
        description = _("architecture-specific build option is not available on aarch64: -m%s") % \
            opt_name
        super().__init__(description=description, filename=filename,
                         lineno=lineno)
        
class NeoverseSpecificBuildOptionIssue(Issue):
    def __init__(self, filename, lineno, opt_name):
        description = (_("Using -mcpu=ampere1 or -mtune=ampere1 for AmpereOne with gcc12.3+/llvm14.04+, "
                         "using -mcpu=ampere1a or -mtune=ampere1a for AmpereOneX with gcc13+. "
                         "Orginal flag: -mcpu=%s") % opt_name)
        super().__init__(description=description, filename=filename,
                         lineno=lineno)