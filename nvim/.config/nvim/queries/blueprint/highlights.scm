(comment) @comment

(quoted_literal) @string
(escape_sequence) @string.escape
(number_literal) @number

(type_name_short (ident) @type)
(type_name_full (ident) @type)
(type_name_external name: (ident) @type)
(template (type_name) @type)

(ident_literal) @variable

(object (ident) @label)
(property name: (ident) @property)
(ext_layout "layout" @keyword)
(ext_layout_prop name: (ident) @property)
(signal name: (ident) @function.method)
(binding_flag) @keyword.modifier
(signal_flag) @keyword.modifier

[
  "using"
  "template"
  "as"
  "bind"
  "bidirectional"
  "swapped"
  "internal-child"
] @keyword

["=" ":" "=>" "|"] @operator
