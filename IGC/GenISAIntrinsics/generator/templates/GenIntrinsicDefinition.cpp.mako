/*========================== begin_copyright_notice ============================

Copyright (C) 2023 Intel Corporation

SPDX-License-Identifier: MIT

============================= end_copyright_notice ===========================*/

#include "GenIntrinsicDefinition.h"

namespace IGC
{
<%!
from Intrinsic_generator import IntrinsicFormatter
%>\
% for el in intrinsic_definitions:

const char* IntrinsicDefinition<llvm::GenISAIntrinsic::ID::${el.name}>::scFunctionRootName =
    ${IntrinsicFormatter.format_name(IntrinsicFormatter.get_prefix() + IntrinsicFormatter.get_intrinsic_suffix(el.name))};
const char* IntrinsicDefinition<llvm::GenISAIntrinsic::ID::${el.name}>::scMainComment =
    ${IntrinsicFormatter.get_comment(el.comment)};
const char* IntrinsicDefinition<llvm::GenISAIntrinsic::ID::${el.name}>::scResultComment =
    ${IntrinsicFormatter.get_comment(el.return_definition.comment)};
% if hasattr(el, 'arguments') and el.arguments and len(el.arguments) > 0:
const std::array<const char*, static_cast<uint32_t>(IntrinsicDefinition<llvm::GenISAIntrinsic::ID::${el.name}>::Argument::Count)>
    IntrinsicDefinition<llvm::GenISAIntrinsic::ID::${el.name}>::scArgumentComments {
    % for arg in el.arguments:
        ${IntrinsicFormatter.get_argument_comment(arg.comment, loop.last)}
    % endfor
    };
% endif

% endfor
} // namespace IGC
