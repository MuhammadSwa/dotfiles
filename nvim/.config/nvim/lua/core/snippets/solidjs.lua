-- SolidJS snippets for LuaSnip
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper to get filename without extension
local function get_component_name()
  local filename = vim.fn.expand("%:t:r")
  return filename:gsub("^%l", string.upper)
end

local solidjs_snippets = {
  -- SolidJS Component
  s("sfc", fmt([[
import type {{ Component }} from 'solid-js';

const {}: Component = () => {{
  return (
    <div>
      {}
    </div>
  );
}};

export default {};
]], {
    f(get_component_name),
    i(1, "content"),
    f(get_component_name),
  })),

  -- SolidJS Component with Props
  s("sfcp", fmt([[
import type {{ Component }} from 'solid-js';

interface {}Props {{
  {}
}}

const {}: Component<{}Props> = (props) => {{
  return (
    <div>
      {}
    </div>
  );
}};

export default {};
]], {
    f(get_component_name),
    i(1, "// props"),
    f(get_component_name),
    f(get_component_name),
    i(2, "content"),
    f(get_component_name),
  })),

  -- createSignal
  s("sig", fmt([[
const [{}, set{}] = createSignal({});
]], {
    i(1, "value"),
    f(function(args) return args[1][1]:gsub("^%l", string.upper) end, { 1 }),
    i(2, "initialValue"),
  })),

  -- createEffect
  s("eff", fmt([[
createEffect(() => {{
  {}
}});
]], { i(1) })),

  -- createMemo
  s("memo", fmt([[
const {} = createMemo(() => {});
]], { i(1, "memoized"), i(2, "computation") })),

  -- createResource
  s("res", fmt([[
const [{}, {{ mutate, refetch }}] = createResource({}, {});
]], { i(1, "data"), i(2, "source"), i(3, "fetcher") })),

  -- Show component
  s("show", fmt([[
<Show when={{{}}} fallback={{{}}}>
  {}
</Show>
]], { i(1, "condition"), i(2, "<></>"), i(3, "content") })),

  -- For component
  s("for", fmt([[
<For each={{{}}}>
  {{({}) => (
    {}
  )}}
</For>
]], { i(1, "items"), i(2, "item"), i(3, "<div>{item}</div>") })),

  -- Switch/Match
  s("switch", fmt([[
<Switch fallback={{{}}}>
  <Match when={{{}}}>
    {}
  </Match>
</Switch>
]], { i(1, "<></>"), i(2, "condition"), i(3, "content") })),

  -- onMount
  s("mount", fmt([[
onMount(() => {{
  {}
}});
]], { i(1) })),

  -- onCleanup
  s("cleanup", fmt([[
onCleanup(() => {{
  {}
}});
]], { i(1) })),

  -- createStore
  s("store", fmt([[
const [{}, set{}] = createStore({{
  {}
}});
]], {
    i(1, "state"),
    f(function(args) return args[1][1]:gsub("^%l", string.upper) end, { 1 }),
    i(2, "// initial state"),
  })),

  -- Tailwind class with classList
  s("tcl", fmt([[
classList={{{{ {}: {} }}}}
]], { i(1, "'class-name'"), i(2, "condition()") })),
}

ls.add_snippets("typescriptreact", solidjs_snippets)
ls.add_snippets("javascriptreact", solidjs_snippets)
