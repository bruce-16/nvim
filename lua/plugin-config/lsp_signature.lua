local status, lsp_signature = pcall(require, "lsp_signature")
if not status then
    vim.notify("没有找到 lsp_signature")
  return
end

lsp_signature.setup(
{
  bind = true,
  -- 边框样式
  handler_opts = {
    -- double、rounded、single、shadow、none
    border = "rounded"
  },
  -- 自动触发
  floating_window = false,
  -- 绑定按键
  toggle_key = require('keybindings').lsp_signature_key,
  -- 虚拟提示关闭
  hint_enable = false,
  -- 正在输入的参数将如何突出显示
  hi_parameter = "LspSignatureActiveParameter"
}
)
