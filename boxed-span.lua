function Span(el)
  local content = pandoc.utils.stringify(el.content)

  if el.classes:includes("boxed") then
    return pandoc.RawInline("latex", "\\fcolorbox{gray}{white}{" .. content .. "}")
  elseif el.classes:includes("bigger-boxed") then
    return pandoc.RawInline("latex", "{\\large\\fcolorbox{gray}{white}{\\strut " .. content .. "}}")
  end
end

function Div(el)
  if el.classes:includes("center") then
    local blocks = {}
    table.insert(blocks, pandoc.RawBlock("latex", "\\begin{center}"))
    for _, item in ipairs(el.content) do
      table.insert(blocks, item)
    end
    table.insert(blocks, pandoc.RawBlock("latex", "\\end{center}"))
    return blocks
  end
end

function Header(el)
  for i, item in ipairs(el.content) do
    if item.t == "Span" and (item.classes:includes("boxed") or item.classes:includes("bigger-boxed")) then
      el.content[i] = Span(item)
    end
  end
  return el
end
